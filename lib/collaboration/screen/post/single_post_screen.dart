import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:daymond_collaboration_app/collaboration/OnboardingSceen.dart';
import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/common/alert_component.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/post_model.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_post.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({
    super.key,
    required this.postId,
    required this.image,
    required this.body,
    required this.description,
    required this.heure,
  });
  final int postId;
  final String image;
  final String body;
  final String description;
  final String heure;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool _loading = false;
  Map<String, dynamic> _poste = {};
  PostModel _post = PostModel();
  // List<dynamic> _commentaires = [];
  int nbCommente = 0;
  String commentaire = '';
  int recruteurId = 0;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController commentaireController = TextEditingController();

  Future<void> poste() async {
    ApiResponse response = await showPoste(widget.postId);

    if (response.error == null) {
      setState(() {
        _poste = response.data as Map<String, dynamic>;
        _post = PostModel.fromJson(_poste);
        // print('=================POST SINGLE================');
        // print(_post);
        _loading = true;
      });
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  Future<void> storeComment() async {
    // ButtomSetData(context, 'Veuillez Patienter ...');
    ApiResponse response = await storeCommentaire(widget.postId, commentaire);
    // ButtomSetData(context, 'Veuillez Patienter ...');

    if (response.error == null) {
      poste();
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  Future<void> suppComment(id) async {
    ApiResponse response = await deleteCommentaire(id);
    if (response.error == null) {
      poste();
    } else if (response.error == unauthorized) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const OnboardingScreen()),
          (route) => false);
      user_services.logout();
    } else {
      AlertComponent().error(context, response.error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    poste();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/actu.png',
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                'Chaîne',
                style: TextStyle(color: black, fontSize: 16),
              ),
            ],
          ),
          actions: [],
        ),
      ),
      body: SingleChildScrollView(
        child: _loading
            ? Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(
                            left: 12,
                            right: 12,
                            bottom: 12,
                            top: 8,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(78, 158, 158, 158),
                                blurRadius: 5,
                                offset: Offset(1, 2),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 15,
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.body,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    widget.description,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 5,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: '${widget.image}',
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        _loading
                            ? Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(
                                  left: 13,
                                  right: 13,
                                  bottom: 10,
                                ),
                                child: _post.comments!.length > 1
                                    ? RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: '>>',
                                              style: TextStyle(
                                                color: Colors.yellow,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  '${_post.comments![0].fullName} et ${_post.comments!.length} autres personnes ont commenté ce poste.',
                                              // ' ${_commentaires[_commentaires.length - 1]['recruteur']['nom']} ${_commentaires[_commentaires.length - 1]['recruteur']['prenom']} et ${_commentaires.length - 1} autres personnes ont commenté ce poste.',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 12, right: 12, top: 8, bottom: 5),
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: _post.comments!.isNotEmpty
                            ? _post.comments!
                                .map(
                                  (e) => recruteurId == 0
                                      ? kCardMe(
                                          e.id,
                                          e.comment,
                                          e.pictureUrl ?? imgUserDefault,
                                          e.fullName,
                                          '${e.createdAtFr}',
                                        )
                                      : kCardVendeurs(
                                          e.comment,
                                          e.pictureUrl ?? imgUserDefault,
                                          e.fullName,
                                          '${e.createdAtFr}',
                                        ),
                                )
                                .toList()
                            : <Widget>[
                                Container(),
                              ],
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 255, 255, 255),
                      highlightColor: const Color.fromARGB(255, 252, 237, 237),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 255, 255, 255),
                      highlightColor: const Color.fromARGB(255, 155, 154, 155),
                      child: Container(
                        alignment: Alignment.centerRight,
                        height: 50,
                        width: MediaQuery.of(context).size.width - 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Colors.transparent,
            ),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: TextFormField(
                  controller: commentaireController,
                  minLines: 1,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Entrez votre commentaire',
                    filled: true,
                    fillColor: Colors.white,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28.0),
                      borderSide: const BorderSide(
                        width: 0.1,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (commentaireController.text != '') {
                    setState(() {
                      commentaire = commentaireController.text;
                      commentaireController.clear();
                    });
                    storeComment();

                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.blue,
                  size: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InkWell kCardMe(id, comment, image, nom, date) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onLongPress: () {
          AlertComponent().confirm(context,
              'Veuillez confirmer la suppréssion svp!', () => suppComment(id));
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: BubbleSpecialOne(
                  text: comment,
                  color: Colors.blue,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: image == null
                          ? CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            )
                          : Image.network(
                              image,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Text(
                    nom,
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    date,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Container kCardVendeurs(comment, image, nom, date) => Container(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: image == null
                        ? CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user.png'),
                          )
                        : Image.network(
                            image,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Text(
                  nom,
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                ),
                Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 8,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: BubbleSpecialOne(
                text: comment,
                isSender: false,
                color: const Color(0xFFE8E8EE),
                textStyle: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
}
