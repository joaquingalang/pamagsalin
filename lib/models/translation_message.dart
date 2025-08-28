class TranslationMessage {
  final String asrText;
  final String? translatedText;

  TranslationMessage({required this.asrText, this.translatedText});

  TranslationMessage copyWith({String? translatedText}) {
    return TranslationMessage(
      asrText: asrText,
      translatedText: translatedText ?? this.translatedText,
    );
  }
}
