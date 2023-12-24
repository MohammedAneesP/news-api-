import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/services/api_services/trending_api.dart';
import 'package:http/http.dart' as http;

part 'trending_news_event.dart';
part 'trending_news_state.dart';

class TrendingNewsBloc extends Bloc<TrendingNewsEvent, TrendingNewsState> {
  TrendingNewsBloc() : super(TrendingNewsInitial()) {
    on<FetchTrending>((event, emit) async {
      try {
        final newses = await fetchingNews();
        if (newses.status != "null") {
          final artics = newses.articles;
          List<dynamic> trendingNews = [];
          for (var element in artics) {
            if (element.urlToImage != "null") {
              Uri? uri = Uri.tryParse(element.urlToImage);
              if (uri != null && uri.isAbsolute) {
                try {
                  var response = await http.head(Uri.parse(element.urlToImage));
                  if (response.statusCode == HttpStatus.ok) {
                    trendingNews.add(element);
                  }
                } catch (e) {
                  log(e.toString());
                }
              } else {
                continue;
              }
            } else {
              continue;
            }
          }
          return emit(TrendingNewsState(
              isLoading: false, trending: trendingNews, errorMessage: ""));
        } else {
          return emit(TrendingNewsState(
              isLoading: false, trending: [], errorMessage: "errorMessage"));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
