class Vendeur {
  int? id;
  int? idUser;
  int? idRecruteur;
  String? nom;
  String? prenom;
  String? pays;
  String? ville;
  String? lienRompu;
  String? roleAs;
  String? profession;
  String? contact;
  String? contact2;
  String? photo;
  String? email;
  String? password;
  String? createdAt;

  int? niveauxInitial;
  int? niveauxActuel;

  Vendeur({
    this.id,
    this.idUser,
    this.idRecruteur,
    this.nom,
    this.prenom,
    this.pays,
    this.ville,
    this.lienRompu,
    this.roleAs,
    this.profession,
    this.contact,
    this.contact2,
    this.email,
    this.photo,
    this.password,
    this.createdAt,
    this.niveauxActuel,
    this.niveauxInitial
  });

  //function qui convertir en json les données du model user
  factory Vendeur.fromJson(Map<String, dynamic> json) {
    return Vendeur(
      idUser: json['vendeur']['user_id'],
      id: json['vendeur']['id'],
      idRecruteur: json['vendeur']['recruteur_id'],
      nom: json['vendeur']['nom'] ?? '',
      prenom: json['vendeur']['prenom'] ?? '',
      pays: json['vendeur']['pays'] ?? '',
      ville: json['vendeur']['ville'] ?? '',
      profession: json['vendeur']['profession'] ?? '',
      lienRompu: json['vendeur']['lien_rupture'] ?? '',
      roleAs: json['vendeur']!= null
          ? json['vendeur']['user']['role_as']
          : null,
      contact: json['vendeur']['contact'] ?? '',
      contact2: json['vendeur']['contact2'] ?? '',
      photo: json['vendeur']['photo'] ?? null,
      createdAt: json['vendeur']['created_at'] ?? '',
      email: json['vendeur']['user'] != null
          ? json['vendeur']['user']['email']
          : null,
      niveauxActuel: json['vendeur']['niveaux'] != 0 ? json['vendeur']['niveaux']['niveaux_increment'] : 0,
      niveauxInitial: json['vendeur']['niveaux'] != 0 ? json['vendeur']['niveaux']['niveaux_base'] : 0,
    );
  }
}
