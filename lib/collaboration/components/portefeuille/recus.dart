import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/models_path.dart';
import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';

import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/produits_vendeurs_recruteurs.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_seller.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';

class PortefeuilleRecuCard extends StatefulWidget {
  const PortefeuilleRecuCard({super.key});

  @override
  State<PortefeuilleRecuCard> createState() => _FournisseurRecuWidgetState();
}

class _FournisseurRecuWidgetState extends State<PortefeuilleRecuCard> {
  final service_recruteur = ServiceSeller();
  final user_services = UserService();
  List<dynamic> array_sorder_by_recruteur = [];
  RecruterFindModel _recruteur = RecruterFindModel();
  bool _loading = true;

  Future getStatistiqueByRecruteur() async {
    // print("==================COMMISION RECU====================");
    ApiResponse order_users = await service_recruteur.CommissionByRecruteur();
    ApiResponse data_user = await user_services.getUserDetail();

    if (order_users.error == null && data_user.error == null) {
      setState(() {
        array_sorder_by_recruteur = order_users.data as List<dynamic>;
        // print(order_users.data);
        _recruteur = data_user.data as RecruterFindModel;
        _loading = false;
      });
    } else {
      // print(order_users.error.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatistiqueByRecruteur();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _loading
          ? Center(child: LaodingData(itemCount: 12))
          : Container(
              padding: EdgeInsets.zero,
              color: Colors.grey.shade100,
              child: Builder(builder: (context) {
                return SingleChildScrollView(
                    child: array_sorder_by_recruteur.length == 0
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.sizeOf(context).height - 270,
                            child: Center(
                              child: Text('Accune vente effectuée'),
                            ),
                          )
                        : ListView.builder(
                            itemCount: array_sorder_by_recruteur.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // print(array_sorder_by_recruteur[index]['from']
                              //     ['person']);
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProduitsVendeursRecruteurs(
                                                    sellerStats: SellerStats(
                                                      firstName:
                                                          array_sorder_by_recruteur[
                                                                          index]
                                                                      ['from']
                                                                  ['data']
                                                              ['first_name'],
                                                      lastName:
                                                          array_sorder_by_recruteur[
                                                                          index]
                                                                      ['from']
                                                                  ['data']
                                                              ['last_name'],
                                                      stars:
                                                          array_sorder_by_recruteur[
                                                                  index]['from']
                                                              ['data']['stars'],
                                                    ),
                                                    nom_prenoms:
                                                        "${array_sorder_by_recruteur[index]['from']['data']['first_name']} ${array_sorder_by_recruteur[index]['from']['data']['last_name']}",
                                                    id: "${array_sorder_by_recruteur[index]['from']['data']['id']}",
                                                    nom_produit:
                                                        '${array_sorder_by_recruteur[index]['order'] == null ? '' : array_sorder_by_recruteur[index]['order']['produit']['nom'] ?? ''}',
                                                    sous_titre:
                                                        '${array_sorder_by_recruteur[index]['order'] == null ? '' : '${array_sorder_by_recruteur[index]['order']['produit']['sous_titre']}'}',
                                                    image_produit:
                                                        '${array_sorder_by_recruteur[index]['order'] == null ? '' : array_sorder_by_recruteur[index]['order']['produit']['image'][0] ?? ''}',
                                                    prix_total:
                                                        array_sorder_by_recruteur[
                                                                        index]
                                                                    ['order'] ==
                                                                null
                                                            ? ''
                                                            : '${array_sorder_by_recruteur[index]['order']['items'][0]['price']}',
                                                    gain: array_sorder_by_recruteur[
                                                                    index]
                                                                ['order'] ==
                                                            null
                                                        ? ''
                                                        : '${array_sorder_by_recruteur[index]['amount']}',
                                                    lieux_vente: '',
                                                    date_vente:
                                                        '${FormatDateHour('${array_sorder_by_recruteur[index]['created_at']}')}',
                                                    prix_vente:
                                                        array_sorder_by_recruteur[
                                                                        index]
                                                                    ['order'] ==
                                                                null
                                                            ? ''
                                                            : '${array_sorder_by_recruteur[index]['order']['items'][0]['product']['price']['price']}',
                                                    bonus:
                                                        '${array_sorder_by_recruteur[index]['amount']}',
                                                  )));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  36, 158, 158, 158),
                                              blurRadius: 5,
                                              offset: Offset(1, 2),
                                            ),
                                            BoxShadow(
                                              color: Color.fromARGB(
                                                  54, 158, 158, 158),
                                              blurRadius: 5,
                                              offset: Offset(2, 1),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          leading: array_sorder_by_recruteur[
                                                              index]['from']
                                                          ['data']['user']
                                                      ['picture_path'] ==
                                                  null
                                              ? CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      "assets/images/user.png"),
                                                )
                                              : Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: NetworkImage(
                                                              '${array_sorder_by_recruteur[index]['from']['data']['user']['picture_path']}'))),
                                                ),
                                          title: Text(
                                            '${array_sorder_by_recruteur[index]['category'].toString().toUpperCase()}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Réçu le ${FormatDateHour('${array_sorder_by_recruteur[index]['created_at']}')}',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          trailing: Text(
                                            '1 Marché\n= ${array_sorder_by_recruteur[index]['amount']} Fcfa',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            }));
              }),
            ),
    );
  }
}
