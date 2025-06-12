// import 'package:collaboration/const/color.dart';
// import 'package:collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';

class ProduitsVendeursRecruteurs extends StatefulWidget {
  const ProduitsVendeursRecruteurs(
      {Key? key,
      required this.id,
      required this.nom_produit,
      required this.sous_titre,
      required this.prix_total,
      required this.gain,
      required this.image_produit,
      required this.lieux_vente,
      required this.date_vente,
      required this.prix_vente,
      required this.bonus,
      this.nom_prenoms,
      this.sellerStats})
      : super(key: key);
  final id;
  final nom_produit;
  final sous_titre;
  final prix_total;
  final gain;
  final image_produit;
  final lieux_vente;
  final date_vente;
  final prix_vente;
  final bonus;
  final nom_prenoms;
  final SellerStats? sellerStats;
  @override
  State<ProduitsVendeursRecruteurs> createState() =>
      _ProduitsVendeursRecruteursState();
}

class _ProduitsVendeursRecruteursState
    extends State<ProduitsVendeursRecruteurs> {
  final service_seller = ServiceSeller();
  final user_service = UserService();

  // Vendeur _vendeur = Vendeur();
  // bool _loading = true;
  int reste = 0;

  // Future<void> getVendeurInfos() async {
  //   final response = await user_service.getVendeurInfos(widget.id);

  //   if (response.error == null) {
  //     setState(() {
  //       _vendeur = response.data as Vendeur;
  //       _loading = false;
  //     });
  //   } else if (response.error == unauthorized) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) => const OnboardingScreen()),
  //         (route) => false);
  //     user_service.logout();

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Veuillez vous conntecter. '),
  //       ),
  //     );
  //   } else {
  //     print(response.error.toString());
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    // getVendeurInfos();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.sellerStats!.user!.picturePath);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: widget.sellerStats == null
                          ? AssetImage("assets/images/user.png")
                          : widget.sellerStats!.user == null ||
                                  widget.sellerStats!.user!.picturePath == null
                              ? AssetImage("assets/images/user.png")
                              : NetworkImage(
                                  '${widget.sellerStats!.user!.picturePath}'),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                '${widget.sellerStats!.firstName} ${widget.sellerStats!.lastName}',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Image.network(
                    '${widget.image_produit}',
                    width: 100,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text('${widget.nom_produit}'),
                  ),
                  subtitle: Column(
                    children: <Widget>[
                      widget.sous_titre == ''
                          ? Container()
                          : Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.sous_titre,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )),
                              ],
                            ),
                      Row(
                        children: [
                          Text('${widget.prix_total} FCFA'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Lieu de vente :   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                              "${widget.lieux_vente}, ${widget.date_vente}"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Prix & livraison :   ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.prix_vente} FCFA",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'Gain du vendeur :   ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${widget.gain} FCFA",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        'Vous bénéficiez de ${widget.bonus} Fcfa sur cette transaction',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 5,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ],
                ),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Niveau',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${widget.sellerStats!.stars} / 5',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // RichText(
              //   text: TextSpan(
              //     children: <TextSpan>[
              //       TextSpan(
              //           text:
              //               'Il ne vous reste plus que ${int.parse('5') - int.parse('${widget.sellerStats!.stars}')} niveaux pour gagner \n un bonus de',
              //           style: TextStyle(color: Colors.black54, fontSize: 14)),
              //       TextSpan(
              //           text: ' 5000 FCA',
              //           style: TextStyle(color: blue, fontSize: 14)),
              //       TextSpan(
              //           text: ' gratuit offert par daymond',
              //           style: TextStyle(color: Colors.black54, fontSize: 14)),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
