class EntryModel {
  const EntryModel({
    required this.id,
    required this.word,
    required this.definition,
    required this.audio,
  });

  final int id;
  final String word;
  final String definition;
  final String audio;

  factory EntryModel.fromJson(Map<String, dynamic> json) {
    return EntryModel(
      id: json['id'],
      word: json['word'],
      definition: json['definition'],
      audio: json['audio']
    );
  }

  String getShortWord() {
    final int maxLength = 20;
    if (word.length < maxLength) return word;
    return "${word.substring(0, maxLength-1)}...";
  }

  String getShortDefinition() {
    final int maxLength = (word.length < 12) ? 32 : 24;
    if (definition.length < maxLength) return definition;
    return "${definition.substring(0, maxLength-1)}...";
  }

}
