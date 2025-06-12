import 'dart:convert';

class CityModel {
  final int? id;
  final String? name;
  final Country? country;

  CityModel({
    this.id,
    this.name,
    this.country,
  });

  factory CityModel.fromRawJson(String str) => CityModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    name: json["name"],
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country!.toJson(),
  };
}

class Country {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;

  Country({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
  });

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    flag: json["flag"],
    code: json["code"],
    currency: json["currency"],
    name: json["name"],
    nationality: json["nationality"],
  );

  Map<String, dynamic> toJson() => {
    "flag": flag,
    "code": code,
    "currency": currency,
    "name": name,
    "nationality": nationality,
  };
}
