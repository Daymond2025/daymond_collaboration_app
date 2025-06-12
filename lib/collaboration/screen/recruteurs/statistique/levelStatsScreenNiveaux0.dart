// ignore_for_file: sort_child_properties_last,

import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/components/profil/ProfilCard.dart';
import 'package:daymond_collaboration_app/collaboration/components/skeletonLaoding.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/const/contants.dart';
import 'package:daymond_collaboration_app/collaboration/models/statistique_model.dart';
import 'package:daymond_collaboration_app/collaboration/screen/recruteurs/check_network_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LevelStatsNiveaux0Screen extends StatefulWidget {
  const LevelStatsNiveaux0Screen({
    Key? key,
    required this.title,
    required this.sommeNiveaux,
    required this.count_level,
    required this.sellersStats,
  }) : super(key: key);
  final title;
  final sommeNiveaux;
  final count_level;
  final List<SellerStats>? sellersStats;
  @override
  State<LevelStatsNiveaux0Screen> createState() =>
      _LevelStatsNiveaux0ScreenState();
}

class _LevelStatsNiveaux0ScreenState extends State<LevelStatsNiveaux0Screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
        bottom: PreferredSize(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.sommeNiveaux,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  FaIcon(
                    FontAwesomeIcons.search,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(60)),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (!connected) return CheckNetworkScreen();
          return ShimmerLoading(
            isLoading: isLaoding,
            contentView: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.8,
                      child: widget.sellersStats == null ||
                              widget.sellersStats!.isEmpty
                          ? Center(child: LaodingData(itemCount: 12))
                          : ListView.builder(
                              itemCount: widget.sellersStats!.length,
                              itemBuilder: (context, i) {
                                SellerStats sellerStats =
                                    widget.sellersStats![i];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: ProfilCard(
                                    contactWat: sellerStats.user!.phoneNumber
                                        .toString(),
                                    sellerStats: sellerStats,
                                    date:
                                        FormatDate('${sellerStats.createdAt}'),
                                    user_id: '${sellerStats.user!.id}',
                                    name:
                                        '${sellerStats.firstName} ${sellerStats.lastName}',
                                    value: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.green,
                                        size: size.width < 350 ? 25 : 35,
                                      ),
                                    ),
                                    profilPicture:
                                        sellerStats.user!.picturePath ?? null,
                                    CardColor: Colors.white,
                                  ),
                                );
                              }),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'There are no bottons to push :)',
            ),
            new Text(
              'Just turn off your internet.',
            ),
          ],
        ),
      ),
    );
  }
}
