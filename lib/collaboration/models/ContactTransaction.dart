class ContactTransaction {
  int? id;
  int? idRecruteur;
  String? operateur;
  String? numero;
  String? createdAt;

  ContactTransaction({
    this.id,
    this.idRecruteur,
    this.numero,
    this.operateur,

    this.createdAt,

  });

  //function qui convertir en json les données du model user
  factory ContactTransaction.fromJson(Map<String, dynamic> json) {
    return ContactTransaction(
      id: json['id'],
      idRecruteur: json['recruteur_id'],
      numero: json['numero'] ?? null,
      operateur: json['operateur'] ?? null,
      createdAt: json['created_at'] ?? '',
    );
  }
}
