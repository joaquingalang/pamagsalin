import 'dart:async';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/cupertino.dart';
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

  // Dynamic threshold fields
  final List<double> _recentDbLevels = [];
  final int _dbBufferSize = 100; // Store recent 100 readings
  double _dynamicThreshold = -40.0;
  final double _thresholdMargin = 8.0; // dB above consistent level
  int _frameCounter = 0;

  StreamSubscription<Uint8List>? _subscription;

  StreamVadRecorder({
    this.thresholdDb = -40.0,
    this.minimumDb = -80,
    this.silenceDurationMs = 400,
    this.onUtterance,
  }) {
    _dynamicThreshold = thresholdDb;
  }

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

    List<double> lastDecibals = List.generate(5, (index) => -160);

    _subscription = stream.listen((frame) async {
      _frameCounter++;
      final amp = await _recorder.getAmplitude();
      final currentDb = amp.current ?? -160.0;

      // Store recent dB levels
      _recentDbLevels.add(currentDb);
      if (_recentDbLevels.length > _dbBufferSize) {
        _recentDbLevels.removeAt(0);
      }

      // Update dynamic threshold every 20 frames
      if (_frameCounter % 20 == 0 && _recentDbLevels.length >= 20) {
        _dynamicThreshold = _calculateConsistentThreshold();
      }

      // Use dynamic threshold for speech detection
      if (currentDb > _dynamicThreshold) {
        _speechDetected = true;
        _lastSpeechTime = DateTime.now();
      }

      if (currentDb > _dynamicThreshold || hasHighDecibals(lastDecibals, _dynamicThreshold)) {
        _buffer.addAll(frame);
      }

      lastDecibals = updateDecibalList(lastDecibals, currentDb);

      if (_speechDetected && _lastSpeechTime != null) {
        final elapsed = DateTime.now().difference(_lastSpeechTime!).inMilliseconds;


        // Check if recent levels are consistently below threshold
        final recentLow = lastDecibals.where((db) => db < _dynamicThreshold - 3.0).length >= 3;

        if (elapsed > silenceDurationMs && recentLow) {
          await _saveUtterance();
          _buffer.clear();
          _speechDetected = false;
          _lastSpeechTime = null;
        }
      }
    });
  }

  double _calculateConsistentThreshold() {
    if (_recentDbLevels.length < 20) return thresholdDb;

    // Find the most consistent dB range
    final sortedLevels = List<double>.from(_recentDbLevels)..sort();

    // Remove extreme outliers (top and bottom 10%)
    final cleanedLength = (sortedLevels.length * 0.8).round();
    final startIndex = (sortedLevels.length * 0.1).round();
    final cleanedLevels = sortedLevels.sublist(startIndex, startIndex + cleanedLength);

    // Find the most frequent range by creating histogram
    final histogram = <int, int>{};
    final binSize = 2.0; // 2 dB bins

    for (final level in cleanedLevels) {
      final bin = (level / binSize).floor();
      histogram[bin] = (histogram[bin] ?? 0) + 1;
    }

    // Find the bin with most occurrences (most consistent level)
    int mostFrequentBin = histogram.keys.first;
    int maxCount = 0;

    for (final entry in histogram.entries) {
      if (entry.value > maxCount) {
        maxCount = entry.value;
        mostFrequentBin = entry.key;
      }
    }

    // Convert bin back to dB and add margin
    final consistentLevel = mostFrequentBin * binSize;
    final newThreshold = consistentLevel + _thresholdMargin;

    // Prevent wild swings - limit change per update
    final maxChange = 5.0;
    final boundedThreshold = newThreshold.clamp(
        _dynamicThreshold - maxChange,
        _dynamicThreshold + maxChange
    );

    // Keep within reasonable bounds
    return boundedThreshold.clamp(-70.0, -15.0);
  }

  // Debugging methods
  double get currentThreshold => _dynamicThreshold;

  double get consistentLevel {
    if (_recentDbLevels.length < 10) return -60.0;
    final sorted = List<double>.from(_recentDbLevels)..sort();
    final middle80Start = (sorted.length * 0.1).round();
    final middle80End = (sorted.length * 0.9).round();
    final middle80 = sorted.sublist(middle80Start, middle80End);
    return middle80.reduce((a, b) => a + b) / middle80.length;
  }

  Future<void> _saveUtterance() async {
    if (_buffer.isEmpty) return;

    final wavPath = await saveBufferAsWav(_buffer, 16000, 1);

    if (onUtterance != null) onUtterance!(wavPath);
  }

  Future<void> stopListening() async {
    await _saveUtterance();
    await _subscription?.cancel();
    await _recorder.stop();
    _buffer.clear();
    _speechDetected = false;
    _lastSpeechTime = null;
    _recentDbLevels.clear();
    _frameCounter = 0;
  }
}