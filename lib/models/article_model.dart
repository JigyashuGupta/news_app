import 'dart:math';

import 'package:intl/intl.dart';

import 'source_model.dart';
// List<String> days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
// List<String> months =
class Article {
  Source source;
  String? author, title, description, url, urlToImage, publishedAt, content;
  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String? truncated = json['content'] as String?;
    String? formatted;
    if(truncated is String){
      truncated = truncated.replaceRange(min(truncated.length,200), truncated.length, '...');
    }
    DateTime? date = DateTime.tryParse(json['publishedAt']);
    if(date is DateTime){
      formatted = DateFormat.MMMMEEEEd().format(date);
    }
    return Article(
        source: Source.fromJson(json['source']),
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: formatted,
        content: truncated);
  }
}
