import 'dart:math';

import 'package:daymond_collaboration_app/collaboration/models/portefeuilleModel.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const baseUrl = "https://v2.daymondboutique.com";
const imgUserDefault = '$baseUrl/assets/user.png';
const apiUrl = "$baseUrl/api/v2";
const usersPath = "$baseUrl/assets/images/users";
const notifPath = "$baseUrl/assets/images/notifications";
const audioFilePath = "$baseUrl/assets/images/audios";
const audioMediaPath = "$baseUrl/assets/images/audios";
final user_services = UserService();

// ERROR-------------------------
const serverError = 'Erreur du server';
const unauthorized = 'Unauthenticated';
const somethingWentWrong = 'Quelque chose s\'est mal passé, réessayez!';

bool isLaoding = true;
List<ModelGetBalance> arraySommeWallet = [];
String? somme;
String? sommeToDay;
String? name;
String? prenom;
String? contact;
String? contact_whatsap;
String? pays;
String? ville;
String? photo;
String? role_as;
String? profession;
String? email;
String? date_vendeur_add;
String? niveaux_increment;
String? niveaux_base;
String? sommeRetire;
String? status_retrait;
String? sommeRetraitEnCours;

const WhatsAppContact = "+2250703430808";

DateTime now = DateTime.now();

//////////////////// API CINETPAY //////////////
double amount = 100;
const API_KEY = '14220312264d268ea3423b0.78662526';
int SITE_ID = 228991;
final String getRandom = Random().nextInt(100000000).toString();
Map<String, dynamic>? response;
Color? color;
IconData? icon;
bool show = false;

////////////////////////////////////// HOUR /////////////
FormatDate(String Date) {
  DateTime date = DateTime.parse(Date);
  var formatter = new DateFormat('EEE d MMM y HH:mm', 'fr_FR');
  var formatedDate = formatter.format(date);
  return formatedDate;
}

FormatDateHour(String Date) {
  DateTime date = DateTime.parse(Date);
  var formatter = new DateFormat('EEE d MMM y', 'fr_FR');
  var formatedDate = formatter.format(date);
  return formatedDate;
}

bool isDateExpired(String dateToCheck) {
  DateTime currentDate = DateTime.now();
  DateTime expirationDate = DateTime.parse(dateToCheck);
  return currentDate.isAfter(expirationDate);
}

String capitalize(String value) {
  return "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
