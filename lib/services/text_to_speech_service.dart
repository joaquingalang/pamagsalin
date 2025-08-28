import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pamagsalin/models/translation_message.dart';

class TextToSpeechService {
  final FlutterTts _tts = FlutterTts();
  bool _initialized = false;

  Future<void> init({
    String language = 'en-US',
    double rate = 0.5,
    double pitch = 1.0,
    double volume = 1.0,
  }) async {
    if (_initialized) return;

    // Optional but handy on iOS/macOS so TTS can mix with other audio.
    if (Platform.isIOS || Platform.isMacOS) {
      await _tts.setSharedInstance(true);
      await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        ],
        IosTextToSpeechAudioMode.voicePrompt,
      ); // See pub.dev docs. :contentReference[oaicite:1]{index=1}
    }

    await _tts.setLanguage(language);
    await _tts.setSpeechRate(rate);
    await _tts.setPitch(pitch);
    await _tts.setVolume(volume);

    // Make speak() await until the utterance completes.
    await _tts.awaitSpeakCompletion(true); // Latest API. :contentReference[oaicite:2]{index=2}

    _initialized = true;
  }

  /// Speak a single string. If [interrupt] is true, stops any ongoing speech first.
  Future<void> speak(String text, {bool interrupt = false}) async {
    await init();
    if (interrupt) await _tts.stop();
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    await _tts.speak(trimmed); // Resolves after completion.
  }

  /// Speak a list of strings sequentially.
  Future<void> speakAll(List<TranslationMessage> messages, {bool interrupt = true}) async {
    await init();
    if (interrupt) await _tts.stop();
    for (final message in messages) {
      if (message.translatedText == null) continue;
      final t = message.translatedText;
      final s = t!.trim();
      if (s.isEmpty) continue;
      await _tts.speak(s); // Each call awaits the previous one finishing.
    }
  }

  Future<void> stop() => _tts.stop();

  void dispose() {
    _tts.stop();
  }
}
