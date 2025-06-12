import 'dart:convert';

List ModelSellerCommandeFromJson(String str) =>
    List<ModelSellerCommande>.from(json.decode(str).map((x) => ModelSellerCommande.fromMap(x)));

class ModelSellerCommande {
  String ? ID_COMMANDE;
  String? type;
  String ? date_livraison;
  String ? heure_livraison;
  String ? frais_livraison;
  String? lieu_livraison;
  String? qte;
  String? nom_produit;
  String? contact1;
  String? contact2;
  String? detail;
  String? prix_max;
  String? prix_proposition;
  String? prix_total;
  String? status;
  String? status_moi;
  String? motif_encours;
  String? motif_attente;
  String? motif_annule;
  String? motif_valide;
  String? name;
  String? prenom;
  String? contact;
  String? pays;
  String? ville;
  String? photo_produit_principal;
  String? prix_vente;
  String? soustitre;
  String? date_commande;
  String? fournisseur_id;

  ModelSellerCommande({
    this.ID_COMMANDE,
    this.type,
    this.date_livraison,
    this.heure_livraison,
    this.frais_livraison,
    this.lieu_livraison,
    this.qte,
    this.nom_produit,
    this.contact1,
    this.contact2,
    this.detail,
    this.prix_max,
    this.prix_proposition,
    this.prix_total,
    this.status,
    this.status_moi,
    this.motif_encours,
    this.motif_attente,
    this.motif_annule,
    this.motif_valide,
    this.name,
    this.prenom,
    this.contact,
    this.pays,
    this.ville,
    this.photo_produit_principal,
    this.prix_vente,
    this.soustitre,
    this.date_commande,
    this.fournisseur_id,
  });





  factory ModelSellerCommande.fromMap(Map<String, dynamic> json) => ModelSellerCommande(
    ID_COMMANDE: json['ID_COMMANDE'].toString(),
    type:json['type'],
    date_livraison:json['date_livraison'],
    heure_livraison:json['heure_livraison'],
    frais_livraison:json['frais_livraison'],
    lieu_livraison:json['lieu_livraison'],
    qte:json['qte'].toString(),
    nom_produit:json['nom_produit'],
    contact1:json['contact1'],
    contact2:json['contact2'],
    detail:json['detail'],
    prix_max:json['prix_max'].toString(),
    prix_proposition:json['prix_proposition'].toString(),
    prix_total:json['prix_total'].toString(),
    status:json['status'].toString(),
    status_moi:json['status_moi'].toString(),
    motif_encours:json['motif_encours'],
    motif_attente:json['motif_attente'],
    motif_annule:json['motif_annule'],
    motif_valide:json['motif_valide'],
    name:json['name'],
    prenom:json['prenom'],
    contact:json['contact'],
    pays:json['pays'],
    ville:json['ville'],
    photo_produit_principal:json['photo_produit_principal'],
    prix_vente:json['prix_vente'].toString(),
    soustitre:json['soustitre'],
    date_commande:json['date_commande'],
    fournisseur_id:json['fournisseur_id'].toString(),
  );
}