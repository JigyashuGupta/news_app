import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/pages/news_page.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/widgets/responsive_children.dart';

import '../models/article_model.dart';

class VerticalNewsList extends StatelessWidget {
  final String country, category; String? query;
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
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
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
                                        'https://images.unsplash.com/photo-1589652717521-10c0d092dea9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
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
                                    Icon(
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
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
    //
  }
}
