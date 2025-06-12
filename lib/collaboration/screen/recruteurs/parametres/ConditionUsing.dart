
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:flutter/material.dart';

class ConditionUsing extends StatefulWidget {
  const ConditionUsing({Key? key}) : super(key: key);

  @override
  State<ConditionUsing> createState() => _ConditionUsingState();
}

class _ConditionUsingState extends State<ConditionUsing> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: black,
        title:  Text("Conditions Générales d'Utilisation".toUpperCase()),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 16),
      ),
      body:SingleChildScrollView(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 padding: EdgeInsets.all(12),
                 width: size.width,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(6),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Padding(
                       padding:
                       const EdgeInsets.only(left: 4, right: 6, top: 10),
                       child: Column(
                         children: [
                           Text("Bienvenue sur l’application des collaborateurs de la société daymond (ci-après dénommée « DAYMOND COLLABORATION »). L’utilisation de l’Application est soumise aux présentes conditions générales d’utilisation (les « CGU »). En accédant ou en utilisant l’Application, vous acceptez d’être lié(e) par ces CGU. Si vous n’acceptez pas ces CGU, vous ne devez pas utiliser notre Application."),
                           ////////// generalité
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Généralités',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("DAYMOND COLLABORATION est un outil de collaboration qui permet aux utilisateurs (les « RECRUTEURS ») de recruter de manière indépendant des vendeurs pour le compte de DAYMOND COLLABORATION en échange d’une commission sur charque vendeurs enregistrés.Les présentes CGU régissent l’utilisation que vous faites de notre Application en tant qu’Utilisateur."),
                           ),
                           //////////// condition utilisation
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Conditions d’utilisation',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Pour utiliser DAYMOND COLLABORATION, vous devez être âgé(e) d'au moins 18 ans. Vous vous engagez à l’utiliser conformément aux lois applicables et aux présentes CGU. Il est interdit d’utiliser DAYMOND COLLABORATION à des fins illégales ou non autorisées."),
                           ),

                           //////////// En utilisant DAYMOND COLLABORATION, vous acceptez de :
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('En utilisant DAYMOND COLLABORATION, vous\n acceptez de :',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Column(
                               children: [
                                 Text("- Fournir des informations exactes, complètes et à jour sur votre compte utilisateur (le « Compte RECRUTEUR »)."),
                                 Text("- Ne créer qu’un seul Compte utilisateur.                 "),
                                 Text("- Ne pas vendre, louer, prêter ou céder votre Compte utilisateur à un tiers."),
                                 Text("- Maintenir la confidentialité de votre mot de passe et de votre compte utilisateur."),
                                 Text("- suivre et coacher les vendeurs sur la bonne pratique de vente"),
                                 Text("- Ne pas utiliser le KIT du badge certifier à des fins personnels, illégales ou non autorisées"),
                                 Text("- Ne pas diffuser de contenus illicites, diffamatoires, ou portant atteinte à des droits de propriété intellectuelle ou à la vie privée ; ni des contenus obscènes, violents, haineux ou discriminatoires."),
                                 Text("- Respecter les droits de propriété intellectuelle, la confidentialité et les données personnelles des des vendeurs que vous recrutés.."),
                               ],
                             ),
                           ),

                           ////////// Limitation de responsabilité
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Limitation de responsabilité',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("DAYMOND COLLABORATION peut contenir des liens vers des sites Web tiers. Nous ne contrôlons pas ces sites Web et déclinons toute responsabilité quant à leur contenu ou leur fonctionnement."),
                           ),

                           ////////// Modification et résiliation
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text(' Modification et résiliation',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Nous nous réservons le droit de modifier ou de supprimer DAYMOND COLLABORATION à tout moment et sans préavis. Nous nous réservons également le droit de suspendre ou de résilier votre Compte utilisateur sans motif ni préavis si vous ne respectez pas les présentes CGU."),
                           ),

                           ////////// Politique de confidentialité
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text(' Politique de confidentialité',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Nous accordons une grande importance à la protection de vos données personnelles. La présente politique de confidentialité décrit les informations que nous collectons, comment nous les utilisons et avec qui nous pouvons les partager."),
                           ),

                           ////////// Collecte et utilisation des données
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Collecte et utilisation des données',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Nous collectons les informations que vous nous fournissez lorsque vous créez votre Compte utilisateur, lorsque vous effectuez des transactions, ou lorsque vous communiquez avec notre équipe de support client. Les informations que nous collectons peuvent comprendre votre nom, votre adresse e-mail, votre adresse postale, votre numéro de téléphone, vos informations de paiement et vos données de localisation.\n\n Nous utilisons ces informations pour améliorer votre expérience utilisateur, traiter vos transactions, vous envoyer des informations promotionnelles, et communiquer avec vous concernant l’utilisation de DAYMOND COLLABORATION."),
                           ),

                           ////////// Partage des données
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Partage des données',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Nous ne partageons pas vos données personnelles avec des tiers pour des fins de marketing sans votre autorisation explicite.\n\n Nous pouvons partager vos données personnelles avec des tiers si cela est nécessaire pour fournir nos services, tels que les vendeurs que vous avez recrutés ou les prestataires de services techniques. Nous pouvons également partager vos données en cas d’une demande légale, d’une enquête gouvernementale, ou pour protéger nos droits ou notre propriété."),
                           ),

                           ////////// Sécurité des données
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Sécurité des données',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Nous avons mis en place des mesures techniques et organisationnelles pour protéger vos données personnelles contre la perte, le vol, l’accès non autorisé, la divulgation ou la destruction."),
                           ),

                           ////////// Vos droits
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Vos droits',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Vous avez le droit de consulter, modifier ou supprimer les données personnelles que nous détenons à votre sujet. Vous pouvez également vous opposer à leur utilisation à des fins de marketing.\n\n Nous conservons vos données personnelles aussi longtemps que nécessaire pour fournir nos services, sauf si une période de conservation plus longue est exigée ou autorisée par la loi."),
                           ),

                           ////////// Contact
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Row(
                               children: [
                                 Text('Contact',style: TextStyle(fontWeight: FontWeight.bold,color: black),)
                               ],
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(top: 12.0),
                             child: Text("Pour toute question ou préoccupation concernant notre politique de confidentialité, n’hésitez pas à nous contacter à l’adresse e-mail suivante : Contact@daymondcollaboration.com\n\n Dernière mise à jour : 23 JUEILLE 2023."),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           ],
         ),
      ),
    );
    
  }
}