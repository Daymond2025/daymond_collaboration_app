import 'dart:convert';

List ModelGetBalanceFromJson(String str) => List<ModelGetBalance>.from(
    json.decode(str).map((x) => ModelGetBalance.fromMap(x)));

class ModelGetBalance {
  String? id;
  String? somme;
  String? user_id;

  ModelGetBalance({
    this.id,
    this.somme,
    this.user_id,
  });
  factory ModelGetBalance.fromMap(Map<String, dynamic> json) => ModelGetBalance(
        id: json['id'],
        somme: json['somme'].toString(),
        user_id: json['user_id'].toString(),
      );
}

List ModelDemandeRetraitFromJson(String str) => List<ModelGetBalance>.from(
    json.decode(str).map((x) => ModelGetBalance.fromMap(x)));

class ModelDemandeRetrait {
  String? ID_TRANSACTION;
  String? user_id;
  String? portefeuille_id;
  String? type;
  String? montant_retrait;
  String? numero_retrait;
  String? reference_retrait;
  String? operateur_retrait;
  String? status_retrait;
  String? DATE_TRANSACTION;
  String? somme;

  ModelDemandeRetrait({
    this.ID_TRANSACTION,
    this.user_id,
    this.portefeuille_id,
    this.type,
    this.montant_retrait,
    this.numero_retrait,
    this.reference_retrait,
    this.operateur_retrait,
    this.status_retrait,
    this.DATE_TRANSACTION,
    this.somme,
  });
  factory ModelDemandeRetrait.fromMap(Map<String, dynamic> json) =>
      ModelDemandeRetrait(
        ID_TRANSACTION: json['ID_TRANSACTION'].toString(),
        user_id: json['user_id'].toString(),
        portefeuille_id: json['portefeuille_id'].toString(),
        type: json['type'].toString(),
        montant_retrait: json['montant_retrait'].toString(),
        numero_retrait: json['numero_retrait'].toString(),
        reference_retrait: json['reference_retrait'].toString(),
        operateur_retrait: json['operateur_retrait'].toString(),
        status_retrait: json['status_retrait'].toString(),
        DATE_TRANSACTION: json['DATE_TRANSACTION'].toString(),
        somme: json['somme'].toString(),
      );
}
