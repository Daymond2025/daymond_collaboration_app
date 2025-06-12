import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/portefeuille/recus.dart';
import 'package:daymond_collaboration_app/collaboration/components/portefeuille/retire.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/screen/portefeuilles/demande_retrait_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/transaction_service.dart';
import 'package:flutter/material.dart';

class PortefeuilleScreen extends StatefulWidget {
  const PortefeuilleScreen({Key? key}) : super(key: key);

  @override
  State<PortefeuilleScreen> createState() =>
      _PortefeuilleFournisseurScreenState();
}

class _PortefeuilleFournisseurScreenState extends State<PortefeuilleScreen> {
  dynamic _portefeuille;
  bool _loading = true;
  TransactionService _transactionService = TransactionService();

  Future getBalanceUser() async {
    ApiResponse response = await _transactionService.getBalanceUser();
    // print(response.data);

    if (response.error == null) {
      setState(() {
        _portefeuille = response.data;
        // print(_portefeuille);
        _loading = false;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez vous conntecter. '),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Echec à la connexion. '),
        ),
      );

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CheckNetworkScreen()),
          (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBalanceUser();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: !_loading
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(1, 22, 103, 10),
                elevation: 3,
                leading: IconButton(
                  tooltip: 'Previous choice',
                  icon: Image.asset(
                    'assets/images/left_arrow_alt.png',
                    width: 150,
                    color: white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/images/port.png', width: 150),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FournisseurPortefeuilleRetraitScreen()));
                    },
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize:
                      _portefeuille['sommeRetraitEnCours'].toString() == '0'
                          ? Size.fromHeight(150.0)
                          : Size.fromHeight(200.0),
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: Text(
                                '${_portefeuille['wallet']['amount']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Text(
                                'CFA',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: Colors.white,
                          height: 60,
                          child: TabBar(
                            labelColor: blue,
                            unselectedLabelColor: black,
                            indicatorColor: blue,
                            tabs: [
                              Tab(
                                  icon: Text(
                                'Réçu',
                                style: TextStyle(fontSize: 16),
                              )),
                              Tab(
                                  icon: Text('Retirer',
                                      style: TextStyle(fontSize: 16)))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(children: [
                PortefeuilleRecuCard(),
                PortefeuilleRetraitCard(
                    sommeRetire: _portefeuille['sommeRetire']),
              ]),
            )
          : Scaffold(
              backgroundColor: Colors.white,
            ),
    );
  }
}
