import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/constants.dart';
import 'package:news_app/constants/hidden.dart';
import 'package:news_app/models/article_model.dart';

class ApiService {
  final endPoint = 'newsapi.org';
  final client = http.Client();
  BuildContext context;
  ApiService({required this.context});

  Future<List<Article>> getArticle(
      String? country, String? category, String? query) async {
    Map<String, String> queryParameters = {

      'apiKey': apiKey,
    };
    if(country != null) {
      queryParameters['country'] = country;
    }
    if (query != null) {
      queryParameters['q'] = query;
    }
    if (category != null) {
      queryParameters['category'] = category;
    }
    // print(queryParameters.toString());
    List<Article> articles = <Article>[];
    try {
      final uri = Uri.https(endPoint, '/v2/top-headlines', queryParameters);
      final response = await client.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json['status'] != 'ok') {
        throw Exception('Api Status: ${json['message']}');
      }
      List<dynamic> body = json['articles'];
      // print(body.length);
      articles = body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } catch (e) {
      SnackBar bar = SnackBar(
        content: Text(
          e.toString(),
          style: headlineText.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(bar);
      // print(e.toString());
      return articles;
    }
  }
}
