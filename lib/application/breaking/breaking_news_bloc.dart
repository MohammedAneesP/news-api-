import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/breaking_news.dart';

part 'breaking_news_event.dart';
part 'breaking_news_state.dart';

class BreakingNewsBloc extends Bloc<BreakingNewsEvent, BreakingNewsState> {
  BreakingNewsBloc() : super(BreakingNewsInitial()) {
    on<FetchBreaking>((event, emit) async {
      News breakNews = await fetchingTrending();
      if (breakNews.status != "null") {
        List<Article> breaking = [];
        for (var element in breakNews.articles) {
          if (element.urlToImage != "null") {
            breaking.add(element);
          } else {
            continue;
          }
        }
        final anList = List.generate(5, (index) => breaking[index]);
        return emit(BreakingNewsState(
            breakingNews: anList, errorMessage: "", isLoading: false));
      } else {
        return emit(BreakingNewsState(
            breakingNews: [], errorMessage: "errorMessage", isLoading: false));
      }
    });
  }
}
