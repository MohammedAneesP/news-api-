// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromJson(json.decode(str));

String newsToJson(News data) => json.encode(data.toJson());

class News {
    final String status;
    final String totalResults;
    final List<Article> articles;

    News({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory News.fromJson(Map<String, dynamic> json) => News(
        status: json["status"].toString(),
        totalResults: json["totalResults"].toString(),
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status.toString(),
        "totalResults": totalResults.toString(),
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    final Source source;
    final String author;
    final String title;
    final String description;
    final String url;
    final String urlToImage;
    final String publishedAt;
    final String content;

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
        source: Source.fromJson(json["source"]),
        author: json["author"].toString(),
        title: json["title"].toString(),
        description: json["description"].toString(),
        url: json["url"].toString(),
        urlToImage: json["urlToImage"].toString(),
        publishedAt: json["publishedAt"].toString(),
        content: json["content"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author.toString(),
        "title": title.toString(),
        "description": description.toString(),
        "url": url.toString(),
        "urlToImage": urlToImage.toString(),
        "publishedAt": publishedAt.toString(),
        "content": content.toString(),
    };
}

class Source {
    final String id;
    final String name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"].toString(),
        name: json["name"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
