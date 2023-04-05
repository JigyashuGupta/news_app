import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/pages/news_page.dart';

class HorizontalNewsListTile extends StatelessWidget {
  final Article article;
  const HorizontalNewsListTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 200,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => NewsPage(news: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: max(100, MediaQuery.of(context).size.height / 7),
              width: 200,
              decoration: BoxDecoration(
                  border: Border.all(color: whiteColor),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        article.urlToImage ??
                      'https://icon-library.com/images/not-found-icon/not-found-icon-28.jpg',
                      ),
                      fit: BoxFit.cover) //<-- SEE HERE
                  ),
            ),
            Text(
              article.title ?? 'Title not found',
              textAlign: TextAlign.center,
              style: headlineText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              article.publishedAt ?? 'Date unknown',
              style: subText,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "By: ${article.author?? 'Unknown'}",
              style: subText,
            )
          ],
        ),
      ),
    );
  }
}
