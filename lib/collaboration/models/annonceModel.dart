import 'dart:convert';

List ModelNotificationFromJson(String str) =>
    List<NotificationRegisDaymond>.from(json.decode(str).map((x) => NotificationRegisDaymond.fromMap(x)));
class NotificationRegisDaymond {
  String ? id;
  String? type;
  String? destinateur;
  String? media;
  String ? message;
  String ? date_programmation;
  String ? references_notif;
  String ? date_add_notif;
  String ? created_at;

  NotificationRegisDaymond({
    this.id,
    this.type,
    this.destinateur,
    this.media,
    this.message,
    this.date_programmation,
    this.references_notif,
    this.date_add_notif,
    this.created_at,
  });
  factory NotificationRegisDaymond.fromMap(Map<String, dynamic> json) => NotificationRegisDaymond(
    id: json['id'].toString(),
    type:json['type'],
    destinateur:json['destinateur'],
    media:json['media'],
    message:json['message'],
    date_programmation:json['date_programmation'],
    references_notif:json['references_notif'],
    created_at:json['created_at'],
    date_add_notif:json['date_add_notif'],

  );
}



List ModelAudioNotificationFromJson(String str) =>
    List<AudioNotification>.from(json.decode(str).map((x) => AudioNotification.fromMap(x)));
class AudioNotification {
  String ? ID_TRANSACTION;
  String ? user_id;
  String? portefeuille_id;
  String ? type;
  String ? montant_retrait;
  String ? numero_retrait;
  String ? reference_retrait;
  String ? operateur_retrait;
  String ? status_retrait;
  String ? DATE_TRANSACTION;
  String ? somme;

  AudioNotification({
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
  factory AudioNotification.fromMap(Map<String, dynamic> json) => AudioNotification(
    ID_TRANSACTION: json['ID_TRANSACTION'],
    user_id:json['user_id'],
    portefeuille_id:json['portefeuille_id'],
    type:json['type'],
    montant_retrait:json['montant_retrait'],
    numero_retrait:json['numero_retrait'],
    reference_retrait:json['reference_retrait'],
    operateur_retrait:json['operateur_retrait'],
    status_retrait:json['status_retrait'],
    DATE_TRANSACTION:json['DATE_TRANSACTION'],
    somme:json['somme'],
  );
}




