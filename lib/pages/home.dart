import 'package:TeslaNews/pages/article.dart';
import 'package:flutter/material.dart';

import '../helper/data.dart';
import '../helper/news.dart';
import '../models/articleModel.dart';
import '../models/categoryModel.dart';
import '../pages/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = [];

  List<ArticleModel> articles = [];

  @override
  void initState() {
    categories = getCategory();
    news();
    super.initState();
  }

  Future news() async {
    ArticleResponse response = ArticleResponse();
    await response.getNews();
    articles = response.news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
              text: 'Tesla',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8.0),
        child: ListView(
          children: [
            // Categories
            Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categoryName: categories[index].categoryName,
                    imageUrl: categories[index].imageUrl,
                  );
                },
              ),
            ),

            // blogs
            Container(
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
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  const CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () { Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoryNews(category: categoryName)));},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical:8.0),
        child: Container(
          margin: EdgeInsets.only(right: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, description, url;

  const BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
    @required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => ArticleView(url: url))),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
