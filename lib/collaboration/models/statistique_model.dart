import 'dart:convert';

class StatistiqueModel {
  final int? inactiveSellers;
  final int? activeSellers;
  final int? totalSellers;
  final int? amountTotal;
  final LevelsStats? levelsStats;

  StatistiqueModel({
    this.inactiveSellers,
    this.activeSellers,
    this.totalSellers,
    this.amountTotal,
    this.levelsStats,
  });

  factory StatistiqueModel.fromRawJson(String str) =>
      StatistiqueModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatistiqueModel.fromJson(Map<String, dynamic> json) =>
      StatistiqueModel(
        inactiveSellers: json["inactive_sellers"],
        activeSellers: json["active_sellers"],
        totalSellers: json["total_sellers"],
        amountTotal: json["amount_total"],
        levelsStats: LevelsStats.fromJson(json["levels"]),
      );

  Map<String, dynamic> toJson() => {
        "inactive_sellers": inactiveSellers,
        "active_sellers": activeSellers,
        "total_sellers": totalSellers,
        "amount_total": amountTotal,
        "levels": levelsStats!.toJson(),
      };
}

class LevelsStats {
  final LevelStats? level0Stats;
  final LevelStats? level1Stats;
  final LevelStats? level2Stats;
  final LevelStats? level3Stats;
  final LevelStats? level4Stats;
  final LevelStats? level5Stats;

  LevelsStats({
    this.level0Stats,
    this.level1Stats,
    this.level2Stats,
    this.level3Stats,
    this.level4Stats,
    this.level5Stats,
  });

  factory LevelsStats.fromRawJson(String str) =>
      LevelsStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LevelsStats.fromJson(Map<String, dynamic> json) => LevelsStats(
        level0Stats: LevelStats.fromJson(json["level_0"]),
        level1Stats: LevelStats.fromJson(json["level_1"]),
        level2Stats: LevelStats.fromJson(json["level_2"]),
        level3Stats: LevelStats.fromJson(json["level_3"]),
        level4Stats: LevelStats.fromJson(json["level_4"]),
        level5Stats: LevelStats.fromJson(json["level_5"]),
      );

  Map<String, dynamic> toJson() => {
        "level_0": level0Stats!.toJson(),
        "level_1": level1Stats!.toJson(),
        "level_2": level2Stats!.toJson(),
        "level_3": level3Stats!.toJson(),
        "level_4": level4Stats!.toJson(),
        "level_5": level5Stats!.toJson(),
      };
}

class LevelStats {
  final int? count;
  final List<SellerStats>? sellersStats;

  LevelStats({
    this.count,
    this.sellersStats,
  });

  factory LevelStats.fromRawJson(String str) =>
      LevelStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LevelStats.fromJson(Map<String, dynamic> json) => LevelStats(
        count: json["count"],
        sellersStats: List<SellerStats>.from(
            json["sellers"].map((x) => SellerStats.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "sellers": List<dynamic>.from(sellersStats!.map((x) => x.toJson())),
      };
}

class SellerStats {
  late final int? id;
  late final UserStats? user;
  late final String? firstName;
  late final String? lastName;
  late final String? job;
  late final String? cityStats; //SellerCityStats
  late final int? stars;
  late final RecruiterStats? recruiter;
  late final dynamic ambassador;
  late final bool? brokenLink;
  late final DateTime? createdAt;
  late final DateTime? updatedAt;
  late final String? createdAtFr;
  late final String? updatedAtFr;

  SellerStats({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.job,
    this.cityStats,
    this.stars,
    this.recruiter,
    this.ambassador,
    this.brokenLink,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory SellerStats.fromRawJson(String str) =>
      SellerStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerStats.fromJson(Map<String, dynamic> json) => SellerStats(
        id: json["id"],
        user: UserStats.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        cityStats: null, //SellerCityStats.fromJson(json["city"]),
        stars: json["stars"],
        recruiter: RecruiterStats.fromJson(json["recruiter"]),
        ambassador: json["ambassador"],
        brokenLink: json["broken_link"],
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
        "city": cityStats, // !.toJson()
        "stars": stars,
        "recruiter": recruiter!.toJson(),
        "ambassador": ambassador,
        "broken_link": brokenLink,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class SellerCityStats {
  final int? id;
  final Name? name;
  final CountryStats? country;

  SellerCityStats({
    this.id,
    this.name,
    this.country,
  });

  factory SellerCityStats.fromRawJson(String str) =>
      SellerCityStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerCityStats.fromJson(Map<String, dynamic> json) =>
      SellerCityStats(
        id: json["id"],
        name: nameValues.map[json["name"]],
        country: CountryStats.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "country": country!.toJson(),
      };
}

class CountryStats {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;
  final List<CityElementStats>? citiesStats;

  CountryStats({
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
    this.citiesStats,
  });

  factory CountryStats.fromRawJson(String str) =>
      CountryStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryStats.fromJson(Map<String, dynamic> json) => CountryStats(
        flag: json["flag"],
        code: json["code"],
        currency: json["currency"],
        name: json["name"],
        nationality: json["nationality"],
        citiesStats: List<CityElementStats>.from(
            json["cities"].map((x) => CityElementStats.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "flag": flag,
        "code": code,
        "currency": currency,
        "name": name,
        "nationality": nationality,
        "cities": List<dynamic>.from(citiesStats!.map((x) => x.toJson())),
      };
}

class CityElementStats {
  final int? id;
  final Name? name;

  CityElementStats({
    this.id,
    this.name,
  });

  factory CityElementStats.fromRawJson(String str) =>
      CityElementStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityElementStats.fromJson(Map<String, dynamic> json) =>
      CityElementStats(
        id: json["id"],
        name: nameValues.map[json["name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
      };
}

enum Name { ABIDJAN, BOUAK, GAGNOA, YAMOUSSOUKRO }

final nameValues = EnumValues({
  "Abidjan": Name.ABIDJAN,
  "Bouaké": Name.BOUAK,
  "Gagnoa": Name.GAGNOA,
  "Yamoussoukro": Name.YAMOUSSOUKRO
});

class RecruiterStats {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? brokenLink;

  RecruiterStats({
    this.id,
    this.firstName,
    this.lastName,
    this.brokenLink,
  });

  factory RecruiterStats.fromRawJson(String str) =>
      RecruiterStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecruiterStats.fromJson(Map<String, dynamic> json) => RecruiterStats(
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

class UserStats {
  final int? id;
  final String? email;
  final String? phoneNumber;
  final dynamic picturePath;

  UserStats({
    this.id,
    this.email,
    this.phoneNumber,
    this.picturePath,
  });

  factory UserStats.fromRawJson(String str) =>
      UserStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserStats.fromJson(Map<String, dynamic> json) => UserStats(
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
