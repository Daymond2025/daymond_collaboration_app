class TransactionRetrait {
  int? id;
  int? idPortefeuille;
  String? type;
  String? operateur;
  String? numero;
  int? montant;
  String? reference;
  String? createdAt;

  TransactionRetrait({
    this.id,
    this.idPortefeuille,
    this.numero,
    this.type,
    this.montant,
    this.reference,
    this.operateur,
    this.createdAt,

  });

  //function qui convertir en json les données du model user
  factory TransactionRetrait.fromJson(Map<String, dynamic> json) {
    return TransactionRetrait(
      id: json['id'],
      idPortefeuille: json['portefeuille_id'] ?? null,
      type: json['type'] ?? null,
      reference: json['reference_retrait'] ?? null,
      numero: json['numero_retrait'] ?? null,
      montant: json['montant_retrait'] ?? null,
      operateur: json['operateur_retrait'] ?? null,
      createdAt: json['created_at'] ?? '',
    );
  }
}
