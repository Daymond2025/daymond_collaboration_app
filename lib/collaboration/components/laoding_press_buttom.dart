import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';



void ButtomSetData(BuildContext context, String text){
  AlertDialog alert = AlertDialog(
    content: Container(
      height: 100,
      child: Column(
        children: [
          Text('${text}',style: TextStyle(fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Center(
              child:  SpinKitPulse(
                color: primary,
                size: 60,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  showDialog(barrierDismissible: true,
    context:context,
    builder:(BuildContext context){
      return alert;
    },
  );
}

class LaodingData extends StatefulWidget {
  const LaodingData({super.key,required this.itemCount});
final itemCount;
  @override
  State<LaodingData> createState() => _LaodingDataState();
}

class _LaodingDataState extends State<LaodingData> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.builder(
          itemCount: widget.itemCount,
          itemBuilder: (BuildContext ctx, index) {
            int timer = 1000;
            return  Shimmer.fromColors(
              baseColor: grey,
              highlightColor: Colors.white,
              period: Duration(milliseconds: timer),
              child: box(),
            );
          }
      ),
    );
  }


  Widget box(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}





void ModalRenvoiCode(BuildContext context){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          title: Column(
            children: [
              Text(
                "E-mail de confirmation incorrect Entrer le bon mail.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 30,),
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                      offset: Offset(2, 1),
                    ),
                  ],
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Entrer le bon mail ',
                    labelStyle: TextStyle(fontSize: 16),
                    focusColor: Colors.black,
                    contentPadding: const EdgeInsets.all(12),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                            5.0),
                        borderSide: BorderSide(
                            color: Colors.grey, width: 0.3)
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ce champ est requis';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          content: Container(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),

                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  child: Container(
                    padding:
                    const EdgeInsets.only(
                        top: 10.0, bottom: 10.0),
                    decoration: const BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0)),
                    ),
                    child: const Text(
                      "Valider",
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}


void SucceFullLogin(BuildContext context){
  ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
          type: ArtSweetAlertType.success,
          title: "Succès !",
          text: "Félicitation, connexion reussie"
      )
  );

}




