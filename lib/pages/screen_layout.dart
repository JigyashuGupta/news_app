import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      backgroundColor: whiteColor,
      bottomNavigationBar: CupertinoTabBar(
        activeColor: primaryColor,
inactiveColor: secondaryColor,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), backgroundColor: whiteColor),
          BottomNavigationBarItem(icon: Icon(Icons.search_outlined), backgroundColor: whiteColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
