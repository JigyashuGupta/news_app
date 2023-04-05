import 'package:flutter/material.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/article_model.dart';

class NewsPage extends StatelessWidget {
  final Article news;
  const NewsPage({Key? key, required this.news}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec sodales turpis, et sollicitudin urna. Nulla vel ipsum eget libero egestas dapibus. Nulla aliquam iaculis mauris, a sodales neque rutrum ac. Mauris et ullamcorper augue, quis tincidunt justo. In neque urna, placerat et justo vitae, porttitor rhoncus odio. Mauris mattis in ligula non dignissim. Proin laoreet pulvinar odio, a rhoncus nisl molestie sit amet. Integer eget efficitur erat. Sed nec turpis scelerisque, varius purus sed, maximus massa. Nam non odio ac nulla semper tincidunt sit amet at felis. Aliquam tempus enim justo, quis pretium leo tempor vel. Aliquam placerat consectetur nisl, vel fermentum libero consequat quis. Morbi blandit ipsum non elementum ultricies. Nam vitae libero tempor, bibendum ex sed, iaculis sapien. Mauris sed tincidunt nunc. Sed sit amet nisl lacus.';
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            height: MediaQuery.of(context).size.height /2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  news.urlToImage??
                      'https://icon-library.com/images/not-found-icon/not-found-icon-28.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter:
                const ColorFilter.mode(Color(0x55000000), BlendMode.srcATop),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: whiteColor,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(buttonBGColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      child: Text(
                        '${news.source.name}',
                        style: headlineText.copyWith(color: whiteColor),
                      ),
                    ),
                    Text(
                      news.title?? 'Title not found',
                      style: titleText.copyWith(color: whiteColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(primaryColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            child: Text(
                              'Author: ${news.author?? 'Unknown'}',
                              style: const TextStyle(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                            child: Row(
                              children: [
                                Icon(Icons.access_time_rounded, color: Colors.grey.shade700, size: 15,),
                                const SizedBox(width: 10,),
                                Text(
                                  news.publishedAt?? 'Unknown',
                                  style: const TextStyle(color: primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Text(news.description?? 'Description not found', style: titleText.copyWith(color: primaryColor), textAlign: TextAlign.justify,),
                ),
                Text(news.content?? 'Content not available',style: contentText,),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

