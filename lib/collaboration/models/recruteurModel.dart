import 'dart:convert';

List SellerModelFromJson(String str) =>
    List<SellerModel>.from(json.decode(str).map((x) => SellerModel.fromMap(x)));

class SellerModel {
  final String? vendeurId;
  final String? recruteurId;
  final String? nom;
  final String? prenom;
  final String? contact;
  final String? contact2;
  final String? pays;
  final String? ville;
  final String? photo;
  final String? role_as;
  final String? profession;
  final String? email;
  final String? createdAt;
  final String? niveauxIncrement;
  final String? niveauxBase;
  final String? lienRupture;

  SellerModel({
    required this.vendeurId,
    required this.recruteurId,
    required this.nom,
    required this.prenom,
    required this.contact,
    required this.contact2,
    required this.pays,
    required this.ville,
    required this.photo,
    required this.role_as,
    required this.profession,
    required this.email,
    required this.niveauxBase,
    required this.niveauxIncrement,
    required this.createdAt,
    required this.lienRupture,
  });

  factory SellerModel.fromMap(Map<String, dynamic> json) => SellerModel(
        recruteurId: json['recruteur_id'].toString(),
        vendeurId: json['id'].toString(),
        nom: json['nom'],
        prenom: json['prenom'],
        contact: json['contact'],
        contact2: json['contact2'],
        pays: json['pays'],
        ville: json['ville'],
        photo: json['photo'],
        role_as: json['role_as'],
        profession: json['profession'],
        email: json['user'] != null ? json['user']['email'] : '',
        niveauxIncrement:  json['niveaux'] != null ? json['niveaux']['niveaux_increment'].toString() : '',
        niveauxBase: json['niveaux'] != null ? json['niveaux']['niveaux_base'].toString() : '',
        createdAt: json['created_at'],
        lienRupture: json['lien_rupture'].toString(),
      );
}
