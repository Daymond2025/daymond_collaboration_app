import 'package:daymond_collaboration_app/collaboration/components/addSeller/AddSellerForm.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/provider/controllers/controller_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewSellersScreen extends StatefulWidget {
  const AddNewSellersScreen({Key? key}) : super(key: key);

  @override
  State<AddNewSellersScreen> createState() => _AddNewSellersScreenState();
}

class _AddNewSellersScreenState extends State<AddNewSellersScreen> {
  final CityController cityController = Get.put(CityController());

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   ButtomSetData(context, 'Veuillez patienter...');
    //   cityController.getCities().then((value) {
    //     if (cityController.cities.isEmpty) {
    //       ButtomSetData(context, 'Erreur de chargement des villes');
    //     } else {
    //       Navigator.pop(context);
    //     }
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(color: black, fontSize: 20),
            iconTheme: const IconThemeData(color: black, size: 30),
            primary: true,
            title: const Text(
              "AJOUTER UN VENDEUR",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 0),
                  child: Text(
                      "Ajouter rapidement un vendeur et profitez \n des avantages de chez daymond.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: black,
                        fontSize: 16,
                      ))),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddSellerForm(
              cities: cityController.cities,
            ),
          ],
        ),
      ),
    );
  }
}
