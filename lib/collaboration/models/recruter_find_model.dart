import 'dart:convert';

class RecruterFindModel {
  final int? id;
  final dynamic picture;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final EntityFind? entity;

  RecruterFindModel({
    this.id,
    this.picture,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
    this.entity,
  });

  factory RecruterFindModel.fromRawJson(String str) =>
      RecruterFindModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecruterFindModel.fromJson(Map<String, dynamic> json) =>
      RecruterFindModel(
        id: json["id"],
        picture: json["picture"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
        entity: EntityFind.fromJson(json["entity"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "picture": picture,
        "email": email,
        "phone_number": phoneNumber,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
        "entity": entity!.toJson(),
      };
}

class EntityFind {
  final int? id;
  final UserFind? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final CityFind? city;
  final int? stars;
  final dynamic focalPoint;
  final DateTime? expiryDate;
  final String? code;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  EntityFind({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.job,
    this.city,
    this.stars,
    this.focalPoint,
    this.expiryDate,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory EntityFind.fromRawJson(String str) =>
      EntityFind.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityFind.fromJson(Map<String, dynamic> json) => EntityFind(
        id: json["id"],
        user: UserFind.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        city: CityFind.fromJson(json["city"]),
        stars: json["stars"],
        focalPoint: json["focal_point"] == null ? null : json["focal_point"],
        expiryDate: json["expiry_date"] == null
            ? null
            : DateTime.parse(json["expiry_date"]),
        code: json["code"] == null ? null : json["code"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "job": job,
        "city": city!.toJson(),
        "stars": stars,
        "focal_point": focalPoint,
      };
}

class CityFind {
  final int? id;
  final String? name;
  final CountryFind? country;

  CityFind({
    this.id,
    this.name,
    this.country,
  });

  factory CityFind.fromRawJson(String str) =>
      CityFind.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityFind.fromJson(Map<String, dynamic> json) => CityFind(
        id: json["id"],
        name: json["name"],
        country: json["country"] == null
            ? null
            : CountryFind.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country!.toJson(),
      };
}

class CountryFind {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;

  CountryFind({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
  });

  factory CountryFind.fromRawJson(String str) =>
      CountryFind.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryFind.fromJson(Map<String, dynamic> json) => CountryFind(
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

class UserFind {
  final int? id;
  final String? email;
  final String? phoneNumber;

  UserFind({
    this.id,
    this.email,
    this.phoneNumber,
  });

  factory UserFind.fromRawJson(String str) =>
      UserFind.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserFind.fromJson(Map<String, dynamic> json) => UserFind(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone_number": phoneNumber,
      };

  /// Converts the `UserFind` instance into a map representation,
  /// with keys corresponding to field names and values to field values.
}
