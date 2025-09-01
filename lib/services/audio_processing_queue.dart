import 'dart:io';
import 'dart:ui';
import 'dart:collection';
import 'package:pamagsalin/services/asr_service.dart';
import 'package:pamagsalin/services/translation_service.dart';

class AudioProcessingQueue {

  final Queue<String> _queue = Queue<String>();
  bool _isProcessing = false;

  final AsrService _asrService = AsrService();
  final TranslationService _translationService = TranslationService();

  final Function(String) onAsrComplete;
  final Function(String, String) onTranslationComplete;
  final VoidCallback onStart;
  final VoidCallback onComplete;

  AudioProcessingQueue({
    required this.onAsrComplete,
    required this.onTranslationComplete,
    required this.onStart,
    required this.onComplete,
  });

  Future<void> add(String audioPath) async {
    _queue.add(audioPath);
    _processNext();
  }

  Future<void> _processNext() async {
    if (_isProcessing) return;

    if (_queue.isEmpty) {
      onComplete();
      return;
    }

    _isProcessing = true;
    final audioPath = _queue.removeFirst();

    try {
      onStart();
      final asrText = await _sendToAsr(audioPath);

      if (asrText == null || asrText.isEmpty) {
        throw Exception('Empty audio file passed.');
      }

      onAsrComplete(asrText.toLowerCase());

      final translatedText = await _sentToTranslator(asrText);
      onTranslationComplete(asrText.toLowerCase(), translatedText!.toLowerCase());
    } catch (e) {
      print('Error processing $audioPath: $e');
    } finally {
      _isProcessing = false;
      _processNext();
    }
  }

  Future<String?> _sendToAsr(String audioPath) async {
    final audioFile = File(audioPath);
    final recognized = await _asrService.transcribeAudio(audioFile);
    return recognized;
  }

  Future<String?> _sentToTranslator(String text) async {
    final translated = await _translationService.translate(text);
    return translated;
  }


}