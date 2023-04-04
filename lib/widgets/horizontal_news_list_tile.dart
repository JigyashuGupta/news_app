import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';

class HorizontalNewsListTile extends StatelessWidget {
  final Article article;
  const HorizontalNewsListTile({
    Key? key,required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height:max(100,MediaQuery.of(context).size.height/7),
            width: 200,
            decoration: BoxDecoration(
                border: Border.all(color: whiteColor),
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(
                      article.urlToImage?? 'https://images.unsplash.com/photo-1589652717521-10c0d092dea9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                    ),
                    fit: BoxFit.cover) //<-- SEE HERE
                ),
          ),
          Text(
            article.title?? 'Title not found',
            textAlign: TextAlign.center,
            style: headlineText,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            article.publishedAt?? 'Date unknown',
            style: subText,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "By: ${article.author}",
            style: subText,
          )
        ],
      ),
    );
  }
}
