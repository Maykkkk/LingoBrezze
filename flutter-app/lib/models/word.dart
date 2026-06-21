class Word {
  final String id;
  final String word;
  final String meaning;
  final String translation;
  final DateTime? createdAt;

  Word({required this.id, required this.word, required this.meaning, required this.translation, this.createdAt});

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map['id'] ?? '',
      word: map['word'] ?? '',
      meaning: map['meaning'] ?? '',
      translation: map['translation'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
    );
  }

  factory Word.fromJson(Map<String, dynamic> map) {
    return Word(
      id: map['id'] ?? '',
      word: map['word'] ?? '',
      meaning: map['meaning'] ?? '',
      translation: map['translation'] ?? '',
      createdAt: map['createdAt'] != null ? DateTime.tryParse(map['createdAt'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'meaning': meaning,
        'translation': translation,
        'createdAt': createdAt?.toIso8601String(),
      };
}
