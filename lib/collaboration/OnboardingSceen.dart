import 'package:carousel_slider/carousel_slider.dart';
import 'package:daymond_collaboration_app/collaboration/components/laoding_press_buttom.dart';
import 'package:daymond_collaboration_app/collaboration/components/onboarding/OnboardingContents.dart';
import 'package:daymond_collaboration_app/collaboration/const/color.dart';
import 'package:daymond_collaboration_app/collaboration/provider/controllers/controller_path.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/login_screen.dart';
import 'package:daymond_collaboration_app/collaboration/screen/auth/regsiter_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/onboarding/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CityController cityController = Get.put(CityController());
  // late CarouselController _controller;
  CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    // _controller = CarouselController();
    super.initState();
  }

  int _currentPage = 0;
  bool laoding = true;
  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          border: Border.all(color: primary),
          color: _currentPage == index ? primary : Color(0xffcea0c7),
          gradient: _currentPage == index
              ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff880068), primary]
                )
              : LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xffcea0c7),
                    Color(0xffcea0c7),
                    Color(0xffcea0c7),
                  ],
                )),
      margin: const EdgeInsets.only(right: 5),
      height: 10,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20 : 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        title: Text(
          'Daymond collaboration',
          style: TextStyle(
              color: primary, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                animateToClosest: true,
                viewportFraction: 1,
                enlargeCenterPage: false,
                aspectRatio: 1,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
              items: contents
                  .map((item) => Container(
                        //height: size.height,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: Image.asset(
                                item.image,
                                height: size.height * 0.30,
                                width: size.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              height: (height >= 840) ? 20 : 20,
                            ),
                            Text(
                              item.title,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primary,
                                fontSize: (width <= 550) ? 18 : 18,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                item.desc,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  height: 1.2,
                                  fontSize: width <= 321 ? 13 : 15,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (int index) => _buildDots(
                index: index,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.sizeOf(context).height * 0.2,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Container(
                  padding: (width <= 550)
                      ? const EdgeInsets.symmetric(horizontal: 30, vertical: 14)
                      : const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                  width: width,
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Color(0xff880068), primary],
                      )),
                  child: GestureDetector(
                    onTap: () {
                      ButtomSetData(context, 'Veuillez patienter...');
                      cityController.getCities().then((value) {
                        if (cityController.cities.isEmpty) {
                          ButtomSetData(
                              context, 'Erreur de chargement des villes');
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen(
                                        cities: cityController.cities,
                                      )));
                        }
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RegisterScreen(cities: [],)));
                    },
                    child: const Text(
                      "Créer un compte",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                },
                child: Container(
                  width: width,
                  height: width * 0.1,
                  child: Center(
                    child: Text(
                      "Se connecter",
                      style: TextStyle(color: primary, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
