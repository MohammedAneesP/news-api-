import 'dart:convert';
import 'dart:io';

import 'package:news_api/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'package:news_api/widgets/apikey.dart';

Future<News>entertainmentFetch()async{
  final apiParse = Uri.parse("https://newsapi.org/v2/everything?q=entertainment&sortBy=popularity&pageSize=50&apiKey=$apiKey");
  final fetching = await http.get(apiParse);
  if (fetching.statusCode == HttpStatus.ok) {
    final apiDecoding = jsonDecode(fetching.body);
    News entertainmentNews = News.fromJson(apiDecoding);
    return entertainmentNews;
  }else{
    List<Article> anList = [];
    News anNew = News(status: "null", totalResults: "0", articles: anList);
    return anNew;
  }
}