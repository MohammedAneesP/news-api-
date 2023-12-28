import 'dart:convert';
import 'dart:io';

import 'package:news_api/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/widgets/apikey.dart';

Future<News> fetchSports() async {
  final apiParse = Uri.parse(
      "https://newsapi.org/v2/everything?q=health&sortBy=popularity&pageSize=50&apiKey=$apiKey");
  final apiFetching = await http.get(apiParse);
  if (apiFetching.statusCode == HttpStatus.ok) {
    final apiDecoding = jsonDecode(apiFetching.body);
    News sportsNews = News.fromJson(apiDecoding);
    return sportsNews;
  } else {
    List<Article> anList = [];
    News anNew = News(status: "null", totalResults: "0", articles: anList);
    return anNew;
  }
}
