import 'dart:convert';
import 'dart:io';

import 'package:news_api/models/trending_model.dart';
import 'package:news_api/widgets/apikey.dart';
import 'package:http/http.dart' as http;

Future<News> fetchingBreaking() async {
  final anValue = Uri.parse(
      "https://newsapi.org/v2/everything?q=top-headlines&sortBy=popularity&pageSize=70&apiKey=$apiKey");
  final anResp = await http.get(anValue);

  if (anResp.statusCode == HttpStatus.ok) {
    final response = jsonDecode(anResp.body);
    News anNews = News.fromJson(response);
    return anNews;
  }
  List<Article> anList = [];
  News anNew = News(status: "null", totalResults: "0", articles: anList);
  return anNew;
}
