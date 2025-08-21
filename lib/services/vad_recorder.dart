import 'dart:async';
import 'dart:io';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

typedef UtteranceCallback = void Function(String filePath);

class VadRecorder {
  final AudioRecorder recorder;
  final UtteranceCallback? onUtteranceDetected;
  final Function(String)? onStopRecording;

  final double thresholdDb; // e.g. -30
  final int silenceDurationMs; // e.g. 800

  Timer? _pollTimer;
  bool _speechDetected = false;
  DateTime? _lastSpeechTime;

  String? _currentFilePath;

  VadRecorder({
    required this.recorder,
    this.onUtteranceDetected,
    this.onStopRecording,
    this.thresholdDb = -20.0,
    this.silenceDurationMs = 800,
  });

  Future<void> startListening() async {
    if (!await recorder.hasPermission()) {
      throw Exception('Microphone permission denied.');
    }

    // Create a temp path for the recording
    final dir = await getTemporaryDirectory();
    _currentFilePath =
        '${dir.path}/utterance_${DateTime.now().millisecondsSinceEpoch}.wav';

    await recorder.start(
      RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: _currentFilePath!,
    );

    _speechDetected = false;
    _lastSpeechTime = null;

    _pollTimer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      final amp = await recorder.getAmplitude();
      final currentDb = amp.current ?? -160.0;

      if (currentDb > thresholdDb) {
        _speechDetected = true;
        _lastSpeechTime = DateTime.now();
      }

      if (_speechDetected && _lastSpeechTime != null) {
        final elapsed =
            DateTime.now().difference(_lastSpeechTime!).inMilliseconds;
        if (elapsed > silenceDurationMs) {
          await _stopAndFireUtterance();
        }
      }
    });
  }

  Future<void> stopListening() async {
    _pollTimer?.cancel();
    _speechDetected = false;

    final path = await recorder.stop();
    onStopRecording!(path!);
  }

  Future<void> _stopAndFireUtterance() async {
    // _pollTimer?.cancel();

    try {
      final path = await recorder.stop();
      _speechDetected = false;

      if (path != null) {
        onUtteranceDetected!(path);

        // cleanup after sending
        Future.delayed(const Duration(seconds: 5), () {
          final file = File(path);
          if (file.existsSync()) file.deleteSync();
        });
      }
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  void dispose() {
    _pollTimer?.cancel();
  }
}
