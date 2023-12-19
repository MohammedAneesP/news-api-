import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/services/api_services/trending_api.dart';

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
            if (element.urlToImage!="null") {
              trendingNews.add(element);
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
