class Argument {
  final int? id;
  final int decisionId;
  final String title;
  final int value;
  final int isPro;

  Argument({
    this.id,
    required this.decisionId,
    required this.title,
    required this.value,
    required this.isPro,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'decisionId': decisionId,
      'title': title,
      'value': value,
      'isPro': isPro
    };
  }
}
