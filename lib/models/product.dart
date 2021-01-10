class Product {
  Product({
    this.externalLink,
    this.url,
    this.label,
    this.id,
  });

  String externalLink;
  String url;
  String label;
  int id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    externalLink: json["external_link"],
    url: json["url"],
    label: json["label"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "external_link": externalLink,
    "url": url,
    "label": label,
    "id": id,
  };
}