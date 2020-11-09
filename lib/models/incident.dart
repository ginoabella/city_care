class Incident {
  final String title;
  final String description;
  final String imageURL;

  Incident({
    this.title,
    this.description,
    this.imageURL,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    return Incident(
      title: json['title'] as String,
      description: json['description'] as String,
      imageURL: json['imageURL'] as String,
    );
  }
}
