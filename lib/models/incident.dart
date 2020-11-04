class Incident {
  final String title;
  final String description;

  Incident({this.title, this.description});

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}
