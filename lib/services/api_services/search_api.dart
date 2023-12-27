import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/widgets/apikey.dart';

Future<News> fetchSearched(String anQuery) async {
  final fetching =
      Uri.parse("https://newsapi.org/v2/everything?q=$anQuery&pageSize=30&apiKey=$apiKey");
  final anValue = await http.get(fetching);
  if (anValue.statusCode == HttpStatus.ok) {
    final response = jsonDecode(anValue.body);
    News anNews = News.fromJson(response);
    return anNews;
  } else {
    List<Article> anList = [];
    News anNew = News(status: "null", totalResults: "0", articles: anList);
    return anNew;
  }
}
