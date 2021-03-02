import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/articleModel.dart';

class ArticleResponse {
  static const String url =
      'http://newsapi.org/v2/top-headlines?country=in&apiKey=565677e0cca643579880d3691cd619b5';
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      jsonData['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            final data = ArticleModel.fromJson(element);
            news.add(data);
          }
        },
      );
    } else {
      throw Exception('Failed To load News');
    }
  }
}class CategoryResponse {

  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {

    final  url =
        'http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=565677e0cca643579880d3691cd619b5';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      jsonData['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            final data = ArticleModel.fromJson(element);
            news.add(data);
          }
        },
      );
    } else {
      throw Exception('Failed To load News');
    }
  }
}
