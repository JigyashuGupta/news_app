import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 7, vsync: this);
    TextEditingController _textController = TextEditingController();
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
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.menu,
                        size: 30,
                      ),
                    ),
                  ),
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
                                    country = value.code!;
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
                          width: 200,
                          child: TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              suffix: IconButton(onPressed: (){
                                setState((){
                                  query;
                                  country;
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
                  TabBar(
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
                        VerticalNewsList(category: 'business', country: country, query: query),
                        VerticalNewsList(category: 'entertainment', country: country, query: query),
                        VerticalNewsList(category: 'general', country: country, query: query),
                        VerticalNewsList(category: 'health', country: country, query: query),
                        VerticalNewsList(category: 'science', country: country, query: query),
                        VerticalNewsList(category: 'sports', country: country, query: query),
                        VerticalNewsList(category: 'technology', country: country, query: query),
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
