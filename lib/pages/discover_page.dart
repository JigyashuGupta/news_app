import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/widgets/responsive_children.dart';

import '../widgets/vertical_news_list.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  String country = 'in';
  String? query;
  bool isloading = false;
  late TextEditingController _textController;
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
     _textController = TextEditingController();
     _tabController = TabController(length: 8, vsync: this);
  }
  @override
  void dispose(){
    super.dispose();
    _textController.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 20),
                  //   child: Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: Icon(
                  //       Icons.menu,
                  //       size: 30,
                  //     ),
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Discover',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.w900),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'News from all over the world',
                          style: subText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      children: [
                        ResponsiveChildren(
                          size: 300,
                          rowAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Country: ',
                              style: headlineText,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CountryCodePicker(
                                  initialSelection: 'IN',
                                  onChanged: (value){
                                    setState((){
                                      isloading = true;
                                    });
                                    country = value.code!;
                                    setState((){
                                      isloading = false;
                                    });
                                  },
                                  showCountryOnly: false,
                                ),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          height: 80,
                          width: min(200, MediaQuery.of(context).size.width),
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              suffix: IconButton(onPressed: (){
                                setState((){
                                  isloading = true;
                                });
                                query = _textController.text;
                                setState((){
                                  isloading = false;
                                });
                              }, icon: const Icon(Icons.search)),
                              labelText: 'Search for ',
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (isloading)? LoadingAnimationWidget.twoRotatingArc(color: primaryColor, size: MediaQuery.of(context).size.height/10) :TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: primaryColor,
                    labelStyle: headlineText,
                    unselectedLabelStyle:
                        headlineText.copyWith(color: secondaryColor),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    unselectedLabelColor: secondaryColor,
                    tabs: const [
                      Tab(
                        text: 'Search Results',
                      ),
                      Tab(
                        text: 'Business',
                      ),
                      Tab(
                        text: 'Entertainment',
                      ),
                      Tab(
                        text: 'General',
                      ),
                      Tab(
                        text: 'Health',
                      ),
                      Tab(
                        text: 'Science',
                      ),
                      Tab(
                        text: 'Sports',
                      ),
                      Tab(
                        text: 'Technology',
                      ),

                    ],
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height / 2,
                    child: TabBarView(
                      physics: BouncingScrollPhysics(),
                      controller: _tabController,
                      children: [
                        VerticalNewsList(category: null,country: null, query: query,),
                        VerticalNewsList(category: 'business', country: country, query: null),
                        VerticalNewsList(category: 'entertainment', country: country, query: null),
                        VerticalNewsList(category: 'general', country: country, query: null),
                        VerticalNewsList(category: 'health', country: country, query: null),
                        VerticalNewsList(category: 'science', country: country, query: null),
                        VerticalNewsList(category: 'sports', country: country, query: null),
                        VerticalNewsList(category: 'technology', country: country, query: null),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
