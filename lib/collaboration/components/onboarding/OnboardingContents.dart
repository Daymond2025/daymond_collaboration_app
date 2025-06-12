import 'dart:ui';

class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

class Slide {
  final String title;
  final String description;
  final String pathImage;
  final int heightImage;
  final int widthImage;
  final Color backgroundColor;

  Slide({
    required this.title,
    required this.description,
    required this.pathImage,
    required this.heightImage,
    required this.widthImage,
    required this.backgroundColor,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "DEVENIR RECRUTEUR",
    image: "assets/images/p1.png",
    desc: "C'est de gagnez de l'argent sans limite en\n automatique, encore et encore.",
  ),
  OnboardingContents(
    title: "DEVENIR RECRUTEUR",
    image: "assets/images/p2.png",
    desc: "C'est de travailler avec des professionnels sans engagement et cela de maniere indépendant",
  ),
  OnboardingContents(
    title: "DEVENIR RECRUTEUR",
    image: "assets/images/p3.png",
    desc: "C'est gagner de l'argent avec son telephone portable, dans sa ville et quel que soit son statut social",
  ),
];