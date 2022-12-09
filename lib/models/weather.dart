class Weather {
  Weather({
    this.id,
    this.minTemp,
    this.maxTemp,
    this.day,
    this.date,
    this.timestamp,
    this.icon,
    this.isToday,
  });

  int id = 0;
  double minTemp;
  double maxTemp;
  String day;
  String date;
  int timestamp;
  String icon;
  bool isToday;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    minTemp: json["min_temp"].toDouble(),
    maxTemp: json["max_temp"].toDouble(),
    day: json["day"],
    date: json["date"],
    timestamp: json["timestamp"],
    icon: json["icon"],
    isToday: json["is_today"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "min_temp": minTemp,
    "max_temp": maxTemp,
    "day": day,
    "date": date,
    "timestamp": timestamp,
    "icon": icon,
    "is_today": isToday,
    "id": id,
  };
}