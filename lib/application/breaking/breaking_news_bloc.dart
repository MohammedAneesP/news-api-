import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/breaking_news.dart';

part 'breaking_news_event.dart';
part 'breaking_news_state.dart';

List<Article> forBreaking = [];

class BreakingNewsBloc extends Bloc<BreakingNewsEvent, BreakingNewsState> {
  BreakingNewsBloc() : super(BreakingNewsInitial()) {
    on<FetchBreaking>((event, emit) async {
      try {
        News breakNews = await fetchingTrending();
        if (breakNews.status != "null") {
          List<Article> breaking = [];

          final breakingNewsList25 = List.generate(20, (index) {
            if (breakNews.articles[index].urlToImage != "null" &&
                forBreaking.length < breakNews.articles.length) {
              if (forBreaking.isNotEmpty) {
                for (var element in forBreaking) {
                  if (element.title != breakNews.articles[index].title) {
                    return breakNews.articles[index];
                  }
                }
              } else {
                return breakNews.articles[index];
              }
            }
          });
          for (var element in breakingNewsList25) {
            forBreaking.add(element!);
          }
          return emit(BreakingNewsState(
              breakingNews: forBreaking, errorMessage: "", isLoading: false));
        } else {
          return emit(BreakingNewsState(
              breakingNews: [],
              errorMessage: "errorMessage",
              isLoading: false));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
