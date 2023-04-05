import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/widgets/responsive_children.dart';

import '../models/article_model.dart';

class VerticalNewsList extends StatelessWidget {
  final String? country, query, category;
  VerticalNewsList({
    required this.category,
    required this.query,
    required this.country,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ApiService client = ApiService(context: context);
    return FutureBuilder(
        future: client.getArticle(country, category, query),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (_, i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => NewsPage(news: articles[i]),
                          ),
                        ),
                        child: ResponsiveChildren(
                          rowAlignment: MainAxisAlignment.start,
                          size: 400,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: whiteColor),
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        articles[i].urlToImage ??
                                            'https://icon-library.com/images/not-found-icon/not-found-icon-28.jpg',
                                      ),
                                      fit: BoxFit.cover) //<-- SEE HERE
                                  ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width:
                                  min(MediaQuery.of(context).size.width * 0.6, 300),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    articles[i].title ?? 'Title Not Found',
                                    style: headlineText,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time_outlined,
                                          size: 12,
                                        ),
                                        Text(
                                          articles[i].publishedAt ??
                                              'Date unknown',
                                          style: subText,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: LoadingAnimationWidget.twoRotatingArc(color: primaryColor, size: MediaQuery.of(context).size.height/20),
            );
          }
        });
    //
  }
}
