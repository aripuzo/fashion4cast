import '../../databases/app_database.dart';

class PlaceResult {
  PlacesData data;
  String message;
  dynamic errors;

  PlaceResult({
    this.data,
    this.message,
    this.errors,
  });

  factory PlaceResult.fromJson(Map<String, dynamic> json){
    var result = PlaceResult(
      message: json["message"],
      errors: json["errors"],
    );
    if(json.containsKey("data"))
      result.data = PlacesData.fromJson(json["data"]);
    return result;
  }

  Map<String, dynamic> toJson() => {
    "data": data != null ? data.toJson(): null,
    "message": message,
    "errors": errors,
  };
}

class PlacesData {
  int currentPage;
  List<Place> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  PlacesData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory PlacesData.fromJson(Map<String, dynamic> json) => PlacesData(
    currentPage: json["current_page"],
    data: List<Place>.from(json["data"].map((x) => Place.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class PlaceData {
  Place data;
  String message;
  dynamic errors;

  PlaceData({
    this.data,
    this.message,
    this.errors,
  });

  factory PlaceData.fromJson(Map<String, dynamic> json) => PlaceData(
    data: Place.fromJson(json["data"]),
    message: json["message"],
    errors: json["errors"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "message": message,
    "errors": errors,
  };
}