import 'package:language_detector/language_detector.dart';

Future<bool> isEnglish(String text) async {
  if (text.trim().isEmpty) return false;

  // Detect the language name (e.g., "English", "Kapampangan")
  final languageName = await LanguageDetector.getLanguageName(content: text);

  return languageName.toLowerCase() == 'english';
}

/// Returns a new list that contains only English strings.
Future<List<String>> filterEnglish(List<String> texts) async {
  final List<String> englishOnly = [];

  for (final text in texts) {
    if (text.trim().isEmpty) continue;

    try {
      final languageName = await LanguageDetector.getLanguageName(content: text);

      if (languageName.toLowerCase() == 'english') {
        englishOnly.add(text);
      }
    } catch (e) {
      // If detection fails, skip that entry
      print('Language detection failed for "$text": $e');
    }
  }

  return englishOnly;
}
