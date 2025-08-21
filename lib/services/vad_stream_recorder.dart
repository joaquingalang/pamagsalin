import 'dart:async';
import 'dart:typed_data';
import 'package:record/record.dart';
import 'package:pamagsalin/utils/audio_helpers.dart';

typedef UtteranceCallback = void Function(String filePath);

class StreamVadRecorder {
  final AudioRecorder _recorder = AudioRecorder();
  final List<int> _buffer = [];
  bool _speechDetected = false;
  DateTime? _lastSpeechTime;

  final double thresholdDb;
  final double minimumDb;
  final int silenceDurationMs;
  final UtteranceCallback? onUtterance;

  StreamSubscription<Uint8List>? _subscription;

  StreamVadRecorder({
    this.thresholdDb = -40.0,
    this.minimumDb = -80,
    this.silenceDurationMs = 800,
    this.onUtterance,
  });

  Future<void> startListening() async {
    if (!await _recorder.hasPermission()) {
      throw Exception('Microphone permission denied.');
    }

    final stream = await _recorder.startStream(
      RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: 16000,
        numChannels: 1,
      ),
    );

    List<double> lastDecibals = List.generate(3, (index) => -160);
    // int countdown = 100;
    _subscription = stream.listen((frame) async {
      // _buffer.addAll(frame);

      final amp = await _recorder.getAmplitude();
      final currentDb = amp.current ?? -160.0;

      // print(currentDb);

      if (currentDb > thresholdDb) {
        _speechDetected = true;
        _lastSpeechTime = DateTime.now();
      }

      if (currentDb > thresholdDb || hasHighDecibals(lastDecibals, thresholdDb)) {
        _buffer.addAll(frame);
      }

      lastDecibals = updateDecibalList(lastDecibals, currentDb);
      print(lastDecibals);

      if (_speechDetected && _lastSpeechTime != null) {
        final elapsed = DateTime.now().difference(_lastSpeechTime!).inMilliseconds;
        if (elapsed > silenceDurationMs) {
          print('SAVING UTTERANCE!');
          await _saveUtterance();
          _buffer.clear();
          _speechDetected = false;
          _lastSpeechTime = null;
        }
      }
    });
  }

  Future<void> _saveUtterance() async {
  if (_buffer.isEmpty) return;

  final wavPath = await saveBufferAsWav(_buffer, 16000, 1);

  print("Utterance saved: $wavPath");
  if (onUtterance != null) onUtterance!(wavPath);
}

  Future<void> stopListening() async {
    await _subscription?.cancel();
    await _recorder.stop();
    _buffer.clear();
    _speechDetected = false;
    _lastSpeechTime = null;
  }
}