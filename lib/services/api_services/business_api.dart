import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/widgets/apikey.dart';

Future<News> fetchBusiness() async {
  final fetching = Uri.parse(
      "https://newsapi.org/v2/everything?q=business&sortBy=popularity&pageSize=50&apiKey=$apiKey");
  final response = await http.get(fetching);
  if (response.statusCode == HttpStatus.ok) {
    final decodedBusiness = jsonDecode(response.body);
    News busiNews = News.fromJson(decodedBusiness);
    return busiNews;
  } else {
    List<Article> anList = [];
    News anNews = News(status: "null", totalResults: "0", articles: anList);
    return anNews;
  }
}
