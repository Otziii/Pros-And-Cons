class Decision {
  final int? id;
  final String title;

  Decision({
    this.id,
    required this.title
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title
    };
  }
}
