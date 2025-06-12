import 'dart:convert';

class WalletModel {
  final Wallet? wallet;
  final int? amountToday;

  WalletModel({
    this.wallet,
    this.amountToday,
  });

  factory WalletModel.fromRawJson(String str) =>
      WalletModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        wallet: Wallet.fromJson(json["wallet"]),
        amountToday: json["amount_today"],
      );

  Map<String, dynamic> toJson() => {
        "wallet": wallet!.toJson(),
        "amount_today": amountToday,
      };
}

class Wallet {
  final int? id;
  final int? amount;
  final int? totalAmount;
  final EntityWallet? entityWallet;

  Wallet({
    this.id,
    this.amount,
    this.totalAmount,
    this.entityWallet,
  });

  factory Wallet.fromRawJson(String str) => Wallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["id"],
        amount: json["amount"],
        totalAmount: json["total_amount"],
        entityWallet: EntityWallet.fromJson(json["entityWallet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "total_amount": totalAmount,
        "entityWallet": entityWallet!.toJson(),
      };
}

class EntityWallet {
  final int? id;
  final UserWallet? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final CityWallet? cityWallet;
  final int? stars;
  final dynamic focalPoint;
  final dynamic expiryDate;
  final dynamic code;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  EntityWallet({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.job,
    this.cityWallet,
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

  factory EntityWallet.fromRawJson(String str) =>
      EntityWallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityWallet.fromJson(Map<String, dynamic> json) => EntityWallet(
        id: json["id"],
        user: UserWallet.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        cityWallet: CityWallet.fromJson(json["cityWallet"]),
        stars: json["stars"],
        focalPoint: json["focal_point"],
        expiryDate: json["expiry_date"],
        code: json["code"],
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
        "cityWallet": cityWallet!.toJson(),
        "stars": stars,
        "focal_point": focalPoint,
        "expiry_date": expiryDate,
        "code": code,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class CityWallet {
  final int? id;
  final String? name;
  final CountryWallet? countryWallet;

  CityWallet({
    this.id,
    this.name,
    this.countryWallet,
  });

  factory CityWallet.fromRawJson(String str) =>
      CityWallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityWallet.fromJson(Map<String, dynamic> json) => CityWallet(
        id: json["id"],
        name: json["name"],
        countryWallet: CountryWallet.fromJson(json["countryWallet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryWallet": countryWallet!.toJson(),
      };
}

class CountryWallet {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;
  final List<CitiesWallet>? citiesWallet;

  CountryWallet({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
    this.citiesWallet,
  });

  factory CountryWallet.fromRawJson(String str) =>
      CountryWallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryWallet.fromJson(Map<String, dynamic> json) => CountryWallet(
        flag: json["flag"],
        code: json["code"],
        currency: json["currency"],
        name: json["name"],
        nationality: json["nationality"],
        citiesWallet: List<CitiesWallet>.from(
            json["citiesWallet"].map((x) => CitiesWallet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "code": code,
        "currency": currency,
        "name": name,
        "nationality": nationality,
        "citiesWallet":
            List<dynamic>.from(citiesWallet!.map((x) => x.toJson())),
      };
}

class CitiesWallet {
  final int? id;
  final String? name;

  CitiesWallet({
    this.id,
    this.name,
  });

  factory CitiesWallet.fromRawJson(String str) =>
      CitiesWallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CitiesWallet.fromJson(Map<String, dynamic> json) => CitiesWallet(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class UserWallet {
  final int? id;
  final String? email;
  final String? phoneNumber;

  UserWallet({
    this.id,
    this.email,
    this.phoneNumber,
  });

  factory UserWallet.fromRawJson(String str) =>
      UserWallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
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
