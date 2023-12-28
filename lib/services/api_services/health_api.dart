import 'dart:convert';
import 'dart:io';

import 'package:news_api/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/widgets/apikey.dart';

Future<News> healthFetch() async {
  final apiParsing = Uri.parse(
      "https://newsapi.org/v2/everything?q=health&sortBy=popularity&pageSize=50&apiKey=$apiKey");
  final apiFetching = await http.get(apiParsing);
  if (apiFetching.statusCode == HttpStatus.ok) {
    final apiDecoding = jsonDecode(apiFetching.body);
    News healthNews = News.fromJson(apiDecoding);
    return healthNews;
  } else {
    List<Article> anList = [];
    News anNew = News(status: "null", totalResults: "0", articles: anList);
    return anNew;
  }
}
