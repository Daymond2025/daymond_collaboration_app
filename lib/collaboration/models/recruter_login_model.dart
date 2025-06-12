import 'dart:convert';

class RecruterLoginModel {
  final UserLogin? user;
  final String? token;
  final Option? option;

  RecruterLoginModel({
    this.user,
    this.token,
    this.option,
  });

  factory RecruterLoginModel.fromRawJson(String str) => RecruterLoginModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecruterLoginModel.fromJson(Map<String, dynamic> json) => RecruterLoginModel(
    user: UserLogin.fromJson(json["user"]),
    token: json["token"],
    option: Option.fromJson(json["option"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user!.toJson(),
    "token": token,
    "option": option!.toJson(),
  };
}

class Option {
  final String? role;

  Option({
    this.role,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
  };
}

class UserLogin {
  final int? id;
  final dynamic picture;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final EntityLogin? entity;

  UserLogin({
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

  factory UserLogin.fromRawJson(String str) => UserLogin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
    id: json["id"],
    picture: json["picture"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAtFr: json["created_at_fr"],
    updatedAtFr: json["updated_at_fr"],
    entity: EntityLogin.fromJson(json["entity"]),
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

class EntityLogin {
  final String? firstName;
  final String? lastName;

  EntityLogin({
    this.firstName,
    this.lastName,
  });

  factory EntityLogin.fromRawJson(String str) => EntityLogin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EntityLogin.fromJson(Map<String, dynamic> json) => EntityLogin(
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
  };
}
