import 'dart:convert';

class BalanceModel {
  final int? amount;
  final int? totalAmount;
  final InfoEntity? entity;

  BalanceModel({
    this.amount,
    this.totalAmount,
    this.entity,
  });

  factory BalanceModel.fromRawJson(String str) => BalanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BalanceModel.fromJson(Map<String, dynamic> json) => BalanceModel(
    amount: json["amount"],
    totalAmount: json["total_amount"],
    entity: InfoEntity.fromJson(json["entity"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "total_amount": totalAmount,
    "entity": entity!.toJson(),
  };
}

class InfoEntity {
  final int? id;
  final UserBalnce? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final CityBalance? cityBalance;
  final int? stars;
  final dynamic focalPoint;

  InfoEntity({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.job,
    this.cityBalance,
    this.stars,
    this.focalPoint,
  });

  factory InfoEntity.fromRawJson(String str) => InfoEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InfoEntity.fromJson(Map<String, dynamic> json) => InfoEntity(
    id: json["id"],
    user: UserBalnce.fromJson(json["user"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    job: json["job"],
    cityBalance: CityBalance.fromJson(json["city"]),
    stars: json["stars"],
    focalPoint: json["focal_point"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user!.toJson(),
    "first_name": firstName,
    "last_name": lastName,
    "job": job,
    "city": cityBalance!.toJson(),
    "stars": stars,
    "focal_point": focalPoint,
  };
}

class CityBalance {
  final int? id;
  final String? name;
  final CountryBalance? countryBalance;

  CityBalance({
    this.id,
    this.name,
    this.countryBalance,
  });

  factory CityBalance.fromRawJson(String str) => CityBalance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityBalance.fromJson(Map<String, dynamic> json) => CityBalance(
    id: json["id"],
    name: json["name"],
    countryBalance: CountryBalance.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": countryBalance!.toJson(),
  };
}

class CountryBalance {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;

  CountryBalance({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
  });

  factory CountryBalance.fromRawJson(String str) => CountryBalance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryBalance.fromJson(Map<String, dynamic> json) => CountryBalance(
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

class UserBalnce {
  final int? id;
  final String? email;
  final String? phoneNumber;

  UserBalnce({
    this.id,
    this.email,
    this.phoneNumber,
  });

  factory UserBalnce.fromRawJson(String str) => UserBalnce.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserBalnce.fromJson(Map<String, dynamic> json) => UserBalnce(
    id: json["id"],
    email: json["email"],
    phoneNumber: json["phone_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phone_number": phoneNumber,
  };
}
