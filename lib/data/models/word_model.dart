import 'dart:convert';

class WordModel {
  final String pali;
  final String meaning;
  WordModel({
    required this.pali,
    required this.meaning,
  });

  WordModel copyWith({
    String? pali,
    String? meaning,
  }) {
    return WordModel(
      pali: pali ?? this.pali,
      meaning: meaning ?? this.meaning,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pali': pali,
      'meaning': meaning,
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      pali: map['pali'] ?? '',
      meaning: map['meaning'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) =>
      WordModel.fromMap(json.decode(source));

  @override
  String toString() => 'WordModel(pali: $pali, meaning: $meaning)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WordModel && other.pali == pali && other.meaning == meaning;
  }

  @override
  int get hashCode => pali.hashCode ^ meaning.hashCode;
}
