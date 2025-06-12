import 'package:daymond_collaboration_app/collaboration/api_response.dart';
import 'package:daymond_collaboration_app/collaboration/components/bottomNavigationBar/BottomTabbarRecruteur.dart';

import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/annonceModel.dart';
import 'package:daymond_collaboration_app/collaboration/screen/notifications/AudioPayer.dart';
import 'package:daymond_collaboration_app/collaboration/screen/notifications/detail_notification_screen.dart';
import 'package:daymond_collaboration_app/collaboration/services/service_annonce.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  State<NotificationScreen> createState() =>
      _NotificationFournisseurScreenState();
}

class _NotificationFournisseurScreenState extends State<NotificationScreen> {
  List<dynamic> array_audio = [];
  bool _loading = true;
  final service_annonce = ServiceAnnonce();
  void getAudioDaymond() async {
    ApiResponse response = await service_annonce.getAudioNotificationDaymond();
    if (response.error == null) {
      final responseData = response.data as Map<String, dynamic>;

      if (responseData.containsKey('audio_send_to_users') &&
          responseData['audio_send_to_users'] is List<dynamic>) {
        final audioSendToUsers =
            responseData['audio_send_to_users'] as List<dynamic>;

        setState(() {
          array_audio = audioSendToUsers;
          _loading = false;
        });
      } else {
        print(
            'audio_send_to_users n\'est pas un tableau valide dans la réponse.');
      }
    } else if (response.error == unauthorized) {
      print('Non autorisé');
    } else {
      print(response.error.toString());
    }
  }

  Future<List<NotificationRegisDaymond>> getNotifyRegisDaymond() async {
    final response = await service_annonce.getNotificationRegisDaymond();
    var data = response['notify_send_to_users'].cast<Map<String, dynamic>>();
    return data
        .map<NotificationRegisDaymond>(
            (json) => NotificationRegisDaymond.fromMap(json))
        .toList();
  }

  late Future<List<NotificationRegisDaymond>> futureNotifications;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAudioDaymond();
    futureNotifications = getNotifyRegisDaymond();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        //automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.black),

        elevation: 0,
        bottom: PreferredSize(
          preferredSize: array_audio.length > 0
              ? Size.fromHeight(110)
              : Size.fromHeight(20),
          child: array_audio.length > 0
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(36, 158, 158, 158),
                          blurRadius: 5,
                          offset: Offset(1, 2),
                        ),
                        BoxShadow(
                          color: Color.fromARGB(54, 158, 158, 158),
                          blurRadius: 5,
                          offset: Offset(2, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        //alignment: Alignment.bottomLeft,
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${audioFilePath}/${array_audio[0]['photo']}'),
                                fit: BoxFit.fill)),
                      ),

                      /// 17 caracteres
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${array_audio[0]['titre']}".toUpperCase(),
                              style: TextStyle(
                                  color: black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                        ],
                      ),
                      subtitle: AudioPayer(
                        audio: '${audioMediaPath}/${array_audio[0]["audio"]}',
                        id_audio: '${array_audio[0]['id']}',
                      ),
                    ),
                  ),
                )
              : Container(),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: size.height * 0.7,
                    child: FutureBuilder<List<NotificationRegisDaymond>>(
                      future: futureNotifications,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  //var name = '${snapshot.data![i].name} ${snapshot.data![i].prenom}';
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsNotificationScreen(
                                                    id: snapshot.data![i].id,
                                                    image:
                                                        '${snapshot.data![i].media}',
                                                    text:
                                                        '${snapshot.data![i].message}',
                                                    date:
                                                        '${FormatDateHour('${snapshot.data![i].date_add_notif}')}',
                                                    type:
                                                        '${snapshot.data![i].type}',
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8, top: 2),
                                      child: Container(
                                          margin: EdgeInsets.all(3),
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
                                            leading: Container(
                                              width: 60,
                                              height: 60,
                                              //padding: EdgeInsets.only(top: 20),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 4,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          'assets/images/regidaymond.png'))),
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${snapshot.data![i].type}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                    '${snapshot.data![i].message}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  )),
                                                ],
                                              ),
                                            ),
                                            trailing: Text(
                                                '${FormatDateHour('${snapshot.data![i].date_add_notif}')}'),
                                          )),
                                    ),
                                  );
                                });
                          } else {
                            return Center(
                                child: const Text(
                              'Empty data',
                              style: TextStyle(color: black),
                              )
                            );
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    )),
              ],
            ),
      bottomNavigationBar: BottomTabbarRecruteur(
        selectedIndex: 3,
      ),
    );
  }
}
