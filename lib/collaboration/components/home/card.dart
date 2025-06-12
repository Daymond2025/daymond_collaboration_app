// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../const/color.dart';

class HomeCard extends StatefulWidget {
  String? title;
  String? description;
  String? imageUrl;
  HomeCard({this.title, this.description, this.imageUrl, Key? key})
      : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top:4),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100
                .withOpacity(0.1),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0.5, 0.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.imageUrl.toString(),
            width: size.width < 350 ? 50 : 60,
            height: size.width < 350 ? 50 : 60,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.title.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: size.width < 350 ? 15 :size.width > 383 && size.width < 390 ? 20 :20,
                        color: primary,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // ignore: prefer_const_constructors
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.description.toString(),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.width < 350 ? 10 :size.width > 383 && size.width < 390 ? 15 :20 ,
                        color: const Color(0xff707070)),
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
