import 'package:TeslaNews/helper/news.dart';
import 'package:TeslaNews/models/articleModel.dart';
import 'package:TeslaNews/pages/home.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  final String category;

  CategoryNews({@required this.category});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = List<ArticleModel>();

  Future categoryNews() async {
    CategoryResponse response = CategoryResponse();
    print(widget.category);
    await response.getNews(widget.category);
    articles = response.news;
  }

  @override
  void initState() {
    categoryNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'Android',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            TextSpan(
              text: 'News',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ]),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: articles.length,
          shrinkWrap: true,
          primary: false,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: BlogTile(
                imageUrl: articles[index].urlToImage,
                description: articles[index].description,
                title: articles[index].title,
                url: articles[index].url,
              ),
            );
          },
        ),
      ),
    );
  }
}
