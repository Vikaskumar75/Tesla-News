class ArticleModel{
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  ArticleModel({this.author, this.title, this.description, this.url, this.urlToImage, this.content});

  factory ArticleModel.fromJson(Map<String,dynamic> json ){
    return ArticleModel(
      author: json['author'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      title: json['title'],
    );
  }
}