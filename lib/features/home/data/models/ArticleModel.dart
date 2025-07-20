import 'dart:convert';

ArticelModel articelModelFromJson(String str) => ArticelModel.fromJson(json.decode(str));

String articelModelToJson(ArticelModel data) => json.encode(data.toJson());

class ArticelModel {
  String status;
  int totalResults;
  List<Article> articles;

  ArticelModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory ArticelModel.fromJson(Map<String, dynamic> json) => ArticelModel(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
  };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

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

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    source: Source.fromJson(json["source"] ?? {}),
    author: json["author"] ?? "",
    title: json["title"] ?? "No Title",
    description: json["description"] ?? "",
    url: json["url"] ?? "",
    urlToImage: json["urlToImage"] ?? "",
    publishedAt: DateTime.tryParse(json["publishedAt"] ?? "") ?? DateTime.now(),
    content: json["content"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "source": source.toJson(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content,
  };
}

class Source {
  String id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
    id: json["id"] ?? "",
    name: json["name"] ?? "Unknown Source",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
