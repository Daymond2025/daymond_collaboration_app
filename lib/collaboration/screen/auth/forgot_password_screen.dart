
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/DefaultButton.dart';
import 'package:daymond_collaboration_app/collaboration/components/input/CostumInput.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/resetpassword_code_verification.dart';
import 'package:daymond_collaboration_app/collaboration/services/user_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final user_service = UserService();
  TextEditingController EmailController = TextEditingController();

// void SendEmailCodeVerify() async {
//   print('Entrée dans SendEmailCodeVerify');
//   ButtomSetData(context, 'Veuillez patienter ...');
//   String codeVerified = "1234567890"; // Remplacez par votre logique pour générer/récupérer le code
//   print('Code de vérification : $codeVerified');
//   new Timer(const Duration(seconds: 1), () async {
//     print('Démarrage du Timer');
//     ApiResponse response = await user_service.SendEmailToRessetPassword(
//       EmailController.text.trim(),
//       codeVerified,
//     );

//     print(
//       response 
//     );
//     print('Erreur API : ${response.error}');
//     print('Réponse de SendEmailToRessetPassword : $response');
//     if (response.error == null) {
//       print('Aucune erreur');
//       Navigator.pop(context);
//       setState(() {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => RessetPasswordCodeVerification(
//               email: EmailController.text.trim(),
//             ),
//           ),
//         );
//       });
//       print('Erreur API : ${response.error}');
//     } else if (user_service.StatusCode == 303) {
//       print('Erreur 303 : cette adresse n\'est associée à aucun compte');
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           "Cette adresse n'est associée à aucun compte",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.red,
//       ));
//       print('Erreur API : ${response.error}');
//     } else {
//       print('Erreur inconnue : ${response.error}');
//       Navigator.pop(context);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(
//           '${response.error}',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.center,
//         ),
//         backgroundColor: Colors.red,
//       ));
//     }
//   });
// }

void SendEmailCodeVerify() async {
  try {
    ButtomSetData(context, 'Veuillez patienter ...');
    
    ApiResponse response = await user_service.SendEmailToRessetPassword(
      EmailController.text.trim(),
    );

    Navigator.pop(context); // Remove loading dialog

    if (response.error == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RessetPasswordCodeVerification(
            email: EmailController.text.trim(),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          response.error ?? "Une erreur s'est produite",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
    }
  } catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Une erreur s'est produite. Veuillez réessayer.",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ));
  }
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        //iconTheme: const IconThemeData(color: primary),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.18),
          child: Card(
            elevation: 0,
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.height * 0.16,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/daymond_logo.png'),
                          fit: BoxFit.contain)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                  child: Text(
                    'Rénitialiser votre mot de passe'.toUpperCase(),
                    style:
                        TextStyle(color: primary, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50, right: 10, left: 10, bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      children: [
                        CostumInput(
                            Label: "Entrer votre Email",
                            Controller: EmailController,
                            Icon: Icon(
                              Icons.email,
                              color: primary,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: DefaultButton(
            text: "Envoyer",
            press: () {
              if (_formKey.currentState!.validate()) {
                SendEmailCodeVerify();
              }
            },
          ),
        ),
      ),
    );
  }
}
