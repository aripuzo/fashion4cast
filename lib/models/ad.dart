class Ad {
  Ad({
    this.imageUrl,
    this.adTitle,
    this.addButtonLabel,
    this.addText,
    this.addLink
  });

  String imageUrl;
  String adTitle;
  String addButtonLabel;
  String addText;
  String addLink;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    imageUrl: json["image_url"],
    adTitle: json["ad_title"],
    addButtonLabel: json["add_button_label"],
    addText: json["add_Text"],
    addLink: json["add_link"]
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "ad_title": adTitle,
    "add_button_label": addButtonLabel,
    "add_Text": addText,
    "add_link": addLink
  };
}

class AdResult {
  AdResult({
    this.data,
  });

  Ad data;

  factory AdResult.fromJson(Map<String, dynamic> json) => AdResult(
    data: Ad.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}