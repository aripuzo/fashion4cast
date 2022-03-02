class Place {
  Place({
    this.id,
    this.name,
    this.description,
    this.lat,
    this.lng,
    this.map,
    this.externalId,
  });

  int id = 0;
  String name;
  String description;
  double lat;
  double lng;
  String map;
  String externalId;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    map: json["map"],
    externalId: json["externalId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "lat": lat,
    "lng": lng,
    "map": map,
    "externalId": externalId,
  };
}