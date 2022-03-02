class Alert {
  String description;
  String title;

  Alert({
    this.title,
    this.description,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
      title: json["title"],
      description: json["description"],
    );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}