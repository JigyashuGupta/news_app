import 'package:flutter/material.dart';
import 'package:news_app/pages/discover_page.dart';
import 'package:news_app/pages/home_page.dart';

//Colors
const Color whiteColor = Color(0xFFFFEFEF);
const Color primaryColor = Color(0xFF151410);
const Color secondaryColor = Colors.grey;
const Color buttonBGColor = Color(0x33EEEEEE);

//Text Styles:
const TextStyle titleText = TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 25, height: 1.3, wordSpacing: 0.5);
const TextStyle headlineText = TextStyle(color: primaryColor,fontWeight: FontWeight.bold, fontSize: 17, wordSpacing: 0.1);
TextStyle contentText = TextStyle(color: Colors.grey.shade700, fontSize: 19, letterSpacing: 0.8, height: 1.3);
const TextStyle subText = TextStyle(color: secondaryColor, fontWeight: FontWeight.w300, fontSize: 12, wordSpacing: 2);

//Pages for PageController
List<Widget>homeScreenItems = [
  HomePage(),
  DiscoverPage(),
];