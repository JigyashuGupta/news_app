import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/discover_page.dart';
import 'package:news_app/pages/home_page.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/pages/screen_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: ScreenLayout(),
    );
  }
}
