import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    this.id,
    this.name,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
  });

  String id;
  String name;
  String state;
  String country;
  double latitude;
  double longitude;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : json["country"],
        latitude:
            json["latitude"] == null ? null : double.parse(json["latitude"]),
        longitude:
            json["longitude"] == null ? null : double.parse(json["longitude"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "state": state == null ? null : state,
        "country": country == null ? null : country,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
      };

  @override
  String toString() => name;
}
