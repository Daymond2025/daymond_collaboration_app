import 'dart:convert';

class TransactionModel {
  final int? id;
  final String? reference;
  final dynamic transactionId;
  final int? amount;
  final String? category;
  final String? status;
  final Order? order;
  final dynamic orderProduct;
  final dynamic transactionModelOperator;
  final dynamic phoneNumber;
  final From? from;
  final Destination? destination;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  TransactionModel({
    this.id,
    this.reference,
    this.transactionId,
    this.amount,
    this.category,
    this.status,
    this.order,
    this.orderProduct,
    this.transactionModelOperator,
    this.phoneNumber,
    this.from,
    this.destination,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory TransactionModel.fromRawJson(String str) =>
      TransactionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json["id"],
        reference: json["reference"],
        transactionId: json["transaction_id"],
        amount: json["amount"],
        category: json["category"],
        status: json["status"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        orderProduct: json["order_product"],
        transactionModelOperator: json["operator"],
        phoneNumber: json["phone_number"],
        from: From.fromJson(json["from"]),
        destination: Destination.fromJson(json["destination"]),
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "transaction_id": transactionId,
        "amount": amount,
        "category": category,
        "status": status,
        "order": order!.toJson(),
        "order_product": orderProduct,
        "operator": transactionModelOperator,
        "phone_number": phoneNumber,
        "from": from!.toJson(),
        "destination": destination!.toJson(),
        "note": note,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class Destination {
  final String? person;
  final DestinationData? data;

  Destination({
    this.person,
    this.data,
  });

  factory Destination.fromRawJson(String str) =>
      Destination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        person: json["person"],
        data: DestinationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "person": person,
        "data": data!.toJson(),
      };
}

class DestinationData {
  final int? id;
  final DataUser? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final DataCityClass? city;
  final int? stars;
  final dynamic focalPoint;
  final DateTime? expiryDate;
  final String? code;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  DestinationData({
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

  factory DestinationData.fromRawJson(String str) =>
      DestinationData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DestinationData.fromJson(Map<String, dynamic> json) =>
      DestinationData(
        id: json["id"],
        user: DataUser.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        city: DataCityClass.fromJson(json["city"]),
        stars: json["stars"],
        focalPoint: json["focal_point"],
        expiryDate: DateTime.parse(json["expiry_date"]),
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
        "city": city!.toJson(),
        "stars": stars,
        "focal_point": focalPoint,
        "expiry_date":
            "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
        "code": code,
        "status": status,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class DataCityClass {
  final int? id;
  final String? name;
  final CountryClass? country;

  DataCityClass({
    this.id,
    this.name,
    this.country,
  });

  factory DataCityClass.fromRawJson(String str) =>
      DataCityClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataCityClass.fromJson(Map<String, dynamic> json) => DataCityClass(
        id: json["id"],
        name: json["name"],
        country: CountryClass.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country": country!.toJson(),
      };
}

class CountryClass {
  final int? id;
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;
  final List<CityElement>? cities;

  CountryClass({
    this.id,
    this.flag,
    this.code,
    this.currency,
    this.name,
    this.nationality,
    this.cities,
  });

  factory CountryClass.fromRawJson(String str) =>
      CountryClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CountryClass.fromJson(Map<String, dynamic> json) => CountryClass(
        id: json["id"],
        flag: json["flag"],
        code: json["code"],
        currency: json["currency"],
        name: json["name"],
        nationality: json["nationality"],
        cities: List<CityElement>.from(
            json["cities"].map((x) => CityElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "flag": flag,
        "code": code,
        "currency": currency,
        "name": name,
        "nationality": nationality,
        "cities": List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class CityElement {
  final int? id;
  final String? name;

  CityElement({
    this.id,
    this.name,
  });

  factory CityElement.fromRawJson(String str) =>
      CityElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CityElement.fromJson(Map<String, dynamic> json) => CityElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class DataUser {
  final int? id;
  final String? email;
  final String? phoneNumber;
  final dynamic picturePath;

  DataUser({
    this.id,
    this.email,
    this.phoneNumber,
    this.picturePath,
  });

  factory DataUser.fromRawJson(String str) =>
      DataUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
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

class From {
  final String? person;
  final SellerClass? data;

  From({
    this.person,
    this.data,
  });

  factory From.fromRawJson(String str) => From.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory From.fromJson(Map<String, dynamic> json) => From(
        person: json["person"],
        data: SellerClass.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "person": person,
        "data": data!.toJson(),
      };
}

class SellerClass {
  final int? id;
  final DataUser? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final String? city;
  final String? country;
  final int? stars;
  final Recruiter? recruiter;
  final dynamic ambassador;
  final bool? brokenLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  SellerClass({
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.job,
    this.city,
    this.country,
    this.stars,
    this.recruiter,
    this.ambassador,
    this.brokenLink,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory SellerClass.fromRawJson(String str) =>
      SellerClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SellerClass.fromJson(Map<String, dynamic> json) => SellerClass(
        id: json["id"],
        user: DataUser.fromJson(json["user"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        job: json["job"],
        city: json["city"],
        country: json["country"],
        stars: json["stars"],
        recruiter: Recruiter.fromJson(json["recruiter"]),
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
        "city": city,
        "country": country,
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

class Recruiter {
  final dynamic picturePath;
  final int? id;
  final String? firstName;
  final String? lastName;

  Recruiter({
    this.picturePath,
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Recruiter.fromRawJson(String str) =>
      Recruiter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Recruiter.fromJson(Map<String, dynamic> json) => Recruiter(
        picturePath: json["picture_path"],
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "picture_path": picturePath,
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
      };
}

class Order {
  final int? id;
  final String? person;
  final String? reference;
  final dynamic detail;
  final int? stars;
  final String? status;
  final int? returned;
  final SellerClass? seller;
  final Client? client;
  final List<Item>? items;
  final Delivery? delivery;
  final Expedition? expedition;
  final AfterExpedition? afterExpedition;
  final Canceled? canceled;
  final Canceled? recieved;
  final Canceled? validated;
  final Canceled? postponed;
  final Canceled? dontPickUp;
  final Canceled? pending;
  final Canceled? inProgress;
  final Canceled? confirmed;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Order({
    this.id,
    this.person,
    this.reference,
    this.detail,
    this.stars,
    this.status,
    this.returned,
    this.seller,
    this.client,
    this.items,
    this.delivery,
    this.expedition,
    this.afterExpedition,
    this.canceled,
    this.recieved,
    this.validated,
    this.postponed,
    this.dontPickUp,
    this.pending,
    this.inProgress,
    this.confirmed,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        person: json["person"],
        reference: json["reference"],
        detail: json["detail"],
        stars: json["stars"],
        status: json["status"],
        returned: json["returned"],
        seller: SellerClass.fromJson(json["seller"]),
        client: Client.fromJson(json["client"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        delivery: Delivery.fromJson(json["delivery"]),
        expedition: Expedition.fromJson(json["expedition"]),
        afterExpedition: AfterExpedition.fromJson(json["after_expedition"]),
        canceled: Canceled.fromJson(json["canceled"]),
        recieved: Canceled.fromJson(json["recieved"]),
        validated: Canceled.fromJson(json["validated"]),
        postponed: Canceled.fromJson(json["postponed"]),
        dontPickUp: Canceled.fromJson(json["dont_pick_up"]),
        pending: Canceled.fromJson(json["pending"]),
        inProgress: Canceled.fromJson(json["in_progress"]),
        confirmed: Canceled.fromJson(json["confirmed"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "person": person,
        "reference": reference,
        "detail": detail,
        "stars": stars,
        "status": status,
        "returned": returned,
        "seller": seller!.toJson(),
        "client": client!.toJson(),
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "delivery": delivery!.toJson(),
        "expedition": expedition!.toJson(),
        "after_expedition": afterExpedition!.toJson(),
        "canceled": canceled!.toJson(),
        "recieved": recieved!.toJson(),
        "validated": validated!.toJson(),
        "postponed": postponed!.toJson(),
        "dont_pick_up": dontPickUp!.toJson(),
        "pending": pending!.toJson(),
        "in_progress": inProgress!.toJson(),
        "confirmed": confirmed!.toJson(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class AfterExpedition {
  final String? actor;
  final AfterExpeditionUser? user;
  final AfterExpeditionData? data;

  AfterExpedition({
    this.actor,
    this.user,
    this.data,
  });

  factory AfterExpedition.fromRawJson(String str) =>
      AfterExpedition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterExpedition.fromJson(Map<String, dynamic> json) =>
      AfterExpedition(
        actor: json["actor"],
        user: AfterExpeditionUser.fromJson(json["user"]),
        data: AfterExpeditionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "actor": actor,
        "user": user!.toJson(),
        "data": data!.toJson(),
      };
}

class AfterExpeditionData {
  final int? id;
  final DataCityClass? city;
  final String? logo;
  final String? name;
  final String? ncc;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? registersPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final String? code;
  final Business? business;

  AfterExpeditionData({
    this.id,
    this.city,
    this.logo,
    this.name,
    this.ncc,
    this.email,
    this.phoneNumber,
    this.address,
    this.registersPath,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
    this.code,
    this.business,
  });

  factory AfterExpeditionData.fromRawJson(String str) =>
      AfterExpeditionData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterExpeditionData.fromJson(Map<String, dynamic> json) =>
      AfterExpeditionData(
        id: json["id"],
        city: DataCityClass.fromJson(json["city"]),
        logo: json["logo"],
        name: json["name"],
        ncc: json["ncc"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        registersPath: json["registers_path"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
        code: json["code"],
        business: Business.fromJson(json["business"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city!.toJson(),
        "logo": logo,
        "name": name,
        "ncc": ncc,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "registers_path": registersPath,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
        "code": code,
        "business": business!.toJson(),
      };
}

class Business {
  final int? id;
  final String? isLocked;
  final String? logo;
  final String? name;
  final String? ncc;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final List<String>? registersPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Business({
    this.id,
    this.isLocked,
    this.logo,
    this.name,
    this.ncc,
    this.email,
    this.phoneNumber,
    this.address,
    this.registersPath,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Business.fromRawJson(String str) =>
      Business.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        id: json["id"],
        isLocked: json["is_locked"],
        logo: json["logo"],
        name: json["name"],
        ncc: json["ncc"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        registersPath: List<String>.from(json["registers_path"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_locked": isLocked,
        "logo": logo,
        "name": name,
        "ncc": ncc,
        "email": email,
        "phone_number": phoneNumber,
        "address": address,
        "registers_path": List<dynamic>.from(registersPath!.map((x) => x)),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class AfterExpeditionUser {
  final int? id;
  final dynamic picture;
  final String? email;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final Entity? entity;

  AfterExpeditionUser({
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

  factory AfterExpeditionUser.fromRawJson(String str) =>
      AfterExpeditionUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AfterExpeditionUser.fromJson(Map<String, dynamic> json) =>
      AfterExpeditionUser(
        id: json["id"],
        picture: json["picture"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
        entity: Entity.fromJson(json["entity"]),
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

class Entity {
  final String? firstName;
  final String? lastName;

  Entity({
    this.firstName,
    this.lastName,
  });

  factory Entity.fromRawJson(String str) => Entity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Entity.fromJson(Map<String, dynamic> json) => Entity(
        firstName: json["first_name"],
        lastName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
      };
}

class Canceled {
  final String? reason;
  final String? date;
  final String? time;

  Canceled({
    this.reason,
    this.date,
    this.time,
  });

  factory Canceled.fromRawJson(String str) =>
      Canceled.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Canceled.fromJson(Map<String, dynamic> json) => Canceled(
        reason: json["reason"],
        date: json["date"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "date": date,
        "time": time,
      };
}

class Client {
  final String? name;
  final String? phoneNumber;
  final dynamic phoneNumber2;

  Client({
    this.name,
    this.phoneNumber,
    this.phoneNumber2,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"],
        phoneNumber: json["phone_number"],
        phoneNumber2: json["phone_number_2"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone_number": phoneNumber,
        "phone_number_2": phoneNumber2,
      };
}

class Delivery {
  final String? date;
  final String? time;
  final DataCityClass? city;

  Delivery({
    this.date,
    this.time,
    this.city,
  });

  factory Delivery.fromRawJson(String str) =>
      Delivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
        date: json["date"],
        time: json["time"],
        city: DataCityClass.fromJson(json["city"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "city": city!.toJson(),
      };
}

class Expedition {
  final String? actor;
  final AfterExpeditionUser? user;
  final dynamic data;

  Expedition({
    this.actor,
    this.user,
    this.data,
  });

  factory Expedition.fromRawJson(String str) =>
      Expedition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Expedition.fromJson(Map<String, dynamic> json) => Expedition(
        actor: json["actor"],
        user: AfterExpeditionUser.fromJson(json["user"]),
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "actor": actor,
        "user": user!.toJson(),
        "data": data,
      };
}

class ShopClass {
  final int? id;
  final String? code;
  final String? name;
  final DataCityClass? city;
  final Business? business;
  final String? address;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  ShopClass({
    this.id,
    this.code,
    this.name,
    this.city,
    this.business,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory ShopClass.fromRawJson(String str) =>
      ShopClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShopClass.fromJson(Map<String, dynamic> json) => ShopClass(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        city: DataCityClass.fromJson(json["city"]),
        business: Business.fromJson(json["business"]),
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "city": city!.toJson(),
        "business": business!.toJson(),
        "address": address,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class Item {
  final String? reference;
  final int? star;
  final int? price;
  final int? quantity;
  final int? fees;
  final dynamic size;
  final dynamic color;
  final Product? product;
  final String? status;
  final int? percentage;
  final int? orderCommission;
  final int? sellerCommission;
  final int? recruiterCommission;
  final int? focalPointCommission;
  final bool? payment;
  final Canceled? canceled;
  final Canceled? validated;
  final dynamic refund;
  final int? totalProduct;
  final int? totalFees;
  final int? total;

  Item({
    this.reference,
    this.star,
    this.price,
    this.quantity,
    this.fees,
    this.size,
    this.color,
    this.product,
    this.status,
    this.percentage,
    this.orderCommission,
    this.sellerCommission,
    this.recruiterCommission,
    this.focalPointCommission,
    this.payment,
    this.canceled,
    this.validated,
    this.refund,
    this.totalProduct,
    this.totalFees,
    this.total,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        reference: json["reference"],
        star: json["star"],
        price: json["price"],
        quantity: json["quantity"],
        fees: json["fees"],
        size: json["size"],
        color: json["color"],
        product: Product.fromJson(json["product"]),
        status: json["status"],
        percentage: json["percentage"],
        orderCommission: json["order_commission"],
        sellerCommission: json["seller_commission"],
        recruiterCommission: json["recruiter_commission"],
        focalPointCommission: json["focal_point_commission"],
        payment: json["payment"],
        canceled: Canceled.fromJson(json["canceled"]),
        validated: Canceled.fromJson(json["validated"]),
        refund: json["refund"],
        totalProduct: json["total_product"],
        totalFees: json["total_fees"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "star": star,
        "price": price,
        "quantity": quantity,
        "fees": fees,
        "size": size,
        "color": color,
        "product": product!.toJson(),
        "status": status,
        "percentage": percentage,
        "order_commission": orderCommission,
        "seller_commission": sellerCommission,
        "recruiter_commission": recruiterCommission,
        "focal_point_commission": focalPointCommission,
        "payment": payment,
        "canceled": canceled!.toJson(),
        "validated": validated!.toJson(),
        "refund": refund,
        "total_product": totalProduct,
        "total_fees": totalFees,
        "total": total,
      };
}

class Product {
  final int? id;
  final String? approvedOrDisapprovedDate;
  final dynamic reasonDisapproved;
  final int? publish;
  final ShopClass? shop;
  final Category? subCategory;
  final StateTransaction? state;
  final dynamic brand;
  final int? popular;
  final int? star;
  final String? code;
  final String? category;
  final String? name;
  final String? subTitle;
  final String? description;
  final String? alias;
  final int? outStock;
  final int? unavailable;
  final int? invisible;
  final int? stock;
  final int? totalStock;
  final int? orderStock;
  final int? views;
  final dynamic link;
  final Price? price;
  final PriceDelivery? priceDelivery;
  final List<String>? images;
  final dynamic sizes;
  final dynamic colors;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Product({
    this.id,
    this.approvedOrDisapprovedDate,
    this.reasonDisapproved,
    this.publish,
    this.shop,
    this.subCategory,
    this.state,
    this.brand,
    this.popular,
    this.star,
    this.code,
    this.category,
    this.name,
    this.subTitle,
    this.description,
    this.alias,
    this.outStock,
    this.unavailable,
    this.invisible,
    this.stock,
    this.totalStock,
    this.orderStock,
    this.views,
    this.link,
    this.price,
    this.priceDelivery,
    this.images,
    this.sizes,
    this.colors,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        approvedOrDisapprovedDate: json["approved_or_disapproved_date"],
        reasonDisapproved: json["reason_disapproved"],
        publish: json["publish"],
        shop: ShopClass.fromJson(json["shop"]),
        subCategory: Category.fromJson(json["sub_category"]),
        state: StateTransaction.fromJson(json["state"]),
        brand: json["brand"],
        popular: json["popular"],
        star: json["star"],
        code: json["code"],
        category: json["category"],
        name: json["name"],
        subTitle: json["sub_title"],
        description: json["description"],
        alias: json["alias"],
        outStock: json["out_stock"],
        unavailable: json["unavailable"],
        invisible: json["invisible"],
        stock: json["stock"],
        totalStock: json["total_stock"],
        orderStock: json["order_stock"],
        views: json["views"],
        link: json["link"],
        price: Price.fromJson(json["price"]),
        priceDelivery: PriceDelivery.fromJson(json["price_delivery"]),
        images: List<String>.from(json["images"].map((x) => x)),
        sizes: json["sizes"],
        colors: json["colors"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "approved_or_disapproved_date": approvedOrDisapprovedDate,
        "reason_disapproved": reasonDisapproved,
        "publish": publish,
        "shop": shop!.toJson(),
        "sub_category": subCategory!.toJson(),
        "state": state!.toJson(),
        "brand": brand,
        "popular": popular,
        "star": star,
        "code": code,
        "category": category,
        "name": name,
        "sub_title": subTitle,
        "description": description,
        "alias": alias,
        "out_stock": outStock,
        "unavailable": unavailable,
        "invisible": invisible,
        "stock": stock,
        "total_stock": totalStock,
        "order_stock": orderStock,
        "views": views,
        "link": link,
        "price": price!.toJson(),
        "price_delivery": priceDelivery!.toJson(),
        "images": List<dynamic>.from(images!.map((x) => x)),
        "sizes": sizes,
        "colors": colors,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
      };
}

class Price {
  final int? price;
  final int? partner;
  final int? supplier;
  final int? seller;
  final int? max;
  final int? min;
  final dynamic commission;
  final int? normal;

  Price({
    this.price,
    this.partner,
    this.supplier,
    this.seller,
    this.max,
    this.min,
    this.commission,
    this.normal,
  });

  factory Price.fromRawJson(String str) => Price.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        price: json["price"],
        partner: json["partner"],
        supplier: json["supplier"],
        seller: json["seller"],
        max: json["max"],
        min: json["min"],
        commission: json["commission"],
        normal: json["normal"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "partner": partner,
        "supplier": supplier,
        "seller": seller,
        "max": max,
        "min": min,
        "commission": commission,
        "normal": normal,
      };
}

class PriceDelivery {
  final int? city;
  final int? noCity;

  PriceDelivery({
    this.city,
    this.noCity,
  });

  factory PriceDelivery.fromRawJson(String str) =>
      PriceDelivery.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PriceDelivery.fromJson(Map<String, dynamic> json) => PriceDelivery(
        city: json["city"],
        noCity: json["no_city"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "no_city": noCity,
      };
}

class StateTransaction {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  StateTransaction({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory StateTransaction.fromRawJson(String str) =>
      StateTransaction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StateTransaction.fromJson(Map<String, dynamic> json) =>
      StateTransaction(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Category {
  final int? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final Category? category;
  final String? picture;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
    this.category,
    this.picture,
  });

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAtFr: json["created_at_fr"],
        updatedAtFr: json["updated_at_fr"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "created_at_fr": createdAtFr,
        "updated_at_fr": updatedAtFr,
        "category": category!.toJson(),
        "picture": picture,
      };
}
