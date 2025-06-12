class Recruteur {
  int? id;
  int? idUser;
  String? nom;
  String? prenom;
  String? pays;
  String? ville;
  String? statusBadge;
  String? roleAs;
  String? profession;
  String? contact;
  String? contact2;
  String? photo;
  String? email;
  String? password;
  String? createdAt;
  String? token;

  String? codeBadge;
  String? dateExpire;

  Recruteur({
    this.id,
    this.idUser,
    this.nom,
    this.prenom,
    this.pays,
    this.ville,
    this.statusBadge,
    this.roleAs,
    this.profession,
    this.contact,
    this.contact2,
    this.email,
    this.photo,
    this.password,
    this.createdAt,
    this.token,
    this.codeBadge,
    this.dateExpire,
  });

  //function qui convertir en json les données du model user
  factory Recruteur.fromJson(Map<String, dynamic> json) {
    return Recruteur(
      idUser: json['recruteur']['user']['id'],
      id: json['recruteur']['id'],
      nom: json['recruteur']['nom'] ?? '',
      prenom: json['recruteur']['prenom'] ?? '',
      pays: json['recruteur']['pays'] ?? '',
      ville: json['recruteur']['ville'] ?? '',
      profession: json['recruteur']['profession'] ?? '',
      roleAs: json['recruteur']['user']['role_as'] ?? '',
      contact: json['recruteur']['contact'] ?? '',
      contact2: json['recruteur']['contact2'] ?? '',
      photo: json['recruteur']['photo'] ?? null,
      createdAt: json['recruteur']['created_at'] ?? '',
      token: json['token'] ?? '',
      email: json['recruteur']['user'] != null
          ? json['recruteur']['user']['email']
          : null,

      statusBadge: json['recruteur']['status_badge'] ?? null,
      codeBadge:
          json['recruteur']['code_badge'] ?? null,
      dateExpire:
          json['recruteur']['badge_expired'] ?? null,
    );
  }
}
