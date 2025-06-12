import 'dart:convert';

class SellerModel {
  final int? id;
  final UserSeller? userSeller;
  final String? firstName;
  final String? lastName;
  final String? job;
  final String? citySeller; //CitySeller
  final int? stars;
  final RecruiterSeller? recruiter;
  final dynamic ambassador;
  final bool? brokenFalse;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  SellerModel(
      {this.id,
      this.userSeller,
      this.firstName,
      this.lastName,
      this.job,
      this.citySeller,
      this.stars,
      this.recruiter,
      this.ambassador,
      this.brokenFalse,
      this.createdAt,
      this.updatedAt,
      this.createdAtFr,
      this.updatedAtFr});

  factory SellerModel.fromRawJson(String str) =>
      SellerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
        id: json["id"],
        userSeller: UserSeller.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        citySeller: json["city"], // CitySeller.fromJson(),
        stars: json["stars"],
        recruiter: RecruiterSeller.fromJson(json["recruiter"]),
        ambassador: json["ambassador"],
        brokenFalse: json["broken_false"] == "false" ? false : true,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": userSeller!.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "job": job,
        "city": citySeller, //!.toJson()
        "stars": stars,
        "recruiter": recruiter!.toJson(),
        "ambassador": ambassador,
        "broken_false": brokenFalse,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr
      };
}

class CitySeller {
  final int? id;
  final String? name;
  final CountrySeller? country;

  CitySeller({
    this.id,
    this.name,
    this.country,
  });

  factory CitySeller.fromRawJson(String str) =>
      CitySeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CitySeller.fromJson(Map<String, dynamic> json) => CitySeller(
        id: json["id"],
        name: json["name"],
        country: CountrySeller.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country!.toJson(),
      };
}

class CountrySeller {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;

  CountrySeller({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
  });

  factory CountrySeller.fromRawJson(String str) =>
      CountrySeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountrySeller.fromJson(Map<String, dynamic> json) => CountrySeller(
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

class RecruiterSeller {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? brokenLink;

  RecruiterSeller({
    this.id,
    this.firstName,
    this.lastName,
    this.brokenLink,
  });

  factory RecruiterSeller.fromRawJson(String str) =>
      RecruiterSeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecruiterSeller.fromJson(Map<String, dynamic> json) =>
      RecruiterSeller(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        brokenLink: json["broken_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "broken_link": brokenLink,
      };
}

class UserSeller {
  final int? id;
  final String? email;
  final String? phoneNumber;
  final String? picturePath;

  UserSeller({
    this.id,
    this.email,
    this.phoneNumber,
    this.picturePath,
  });

  factory UserSeller.fromRawJson(String str) =>
      UserSeller.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSeller.fromJson(Map<String, dynamic> json) => UserSeller(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        picturePath: json["picture_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone_number": phoneNumber,
        "picture_path": picturePath,
      };
}
