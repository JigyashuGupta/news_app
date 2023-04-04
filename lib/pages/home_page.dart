import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/widgets/horizontal_news_list_tile.dart';
import 'package:news_app/widgets/responsive_children.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    ApiService client = ApiService(context: context);
    return Scaffold(
      body: FutureBuilder(
        future: client.getArticle('in', null, '.'),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot){
          if(snapshot.hasData && snapshot.data!.isNotEmpty){
            List<Article> articles = snapshot.data!;
            return ListView(
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  height: max(240, MediaQuery.of(context).size.height / 2.5),
                  //TODO: Learn more not responsive yet
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: whiteColor),
                    borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(40)),
                    image: DecorationImage(
                      image: NetworkImage(
                        articles[0].urlToImage?? 'https://images.unsplash.com/photo-1589652717521-10c0d092dea9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                      ),
                      fit: BoxFit.cover,
                      colorFilter:
                      ColorFilter.mode(Color(0x55000000), BlendMode.srcATop),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.menu,
                            color: whiteColor,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20.0),
                              child: TextButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(buttonBGColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  ' News of the day ',
                                  style: subText.copyWith(color: whiteColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Text(
                              articles[0].title?? 'Title Not Found',
                              style: titleText.copyWith(color: whiteColor),
                              maxLines:
                              (MediaQuery.of(context).size.height > 650) ? 2 : 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Learn More',
                                  style: headlineText.copyWith(color: whiteColor),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (MediaQuery.of(context).size.width >= 200)
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: whiteColor,
                                    size: 25,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ResponsiveChildren(
                          rowAlignment: MainAxisAlignment.spaceBetween,
                          size: 300,
                          children: [
                            Text(
                              'Breaking News',
                              style: titleText.copyWith(color: primaryColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Text(
                              'More',
                              style: headlineText,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: max(200, MediaQuery.of(context).size.height / 3),
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return HorizontalNewsListTile(article: articles[index+1],
                              );
                            },
                            itemCount: articles.length - 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
