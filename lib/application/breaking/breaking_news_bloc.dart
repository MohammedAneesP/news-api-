import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/breaking_news.dart';
import 'package:http/http.dart' as http;
part 'breaking_news_event.dart';
part 'breaking_news_state.dart';

List<Article> forBreaking = [];

class BreakingNewsBloc extends Bloc<BreakingNewsEvent, BreakingNewsState> {
  BreakingNewsBloc() : super(BreakingNewsInitial()) {
    on<FetchBreaking>((event, emit) async {
      try {
        News breakNews = await fetchingBreaking();
        forBreaking.clear();
        if (breakNews.status == "ok") {
          final theBreaking = List.generate(20, (index) {
            if (breakNews.articles[index].urlToImage != "null") {
              return breakNews.articles[index];
            }
          });
          for (var element in theBreaking) {
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
    on<PaginationFetch>((event, emit) async {
      try {
        final fetching = await fetchingBreaking();
        int count = 0;
        if (fetching.status == "ok") {
          List<Article> forPaginate = [];
          for (var element in fetching.articles) {
            if (element.urlToImage != "null" &&
                !forBreaking.any((news) => news.title == element.title)) {
              Uri? uri = Uri.tryParse(element.urlToImage);
              if (uri != null && uri.isAbsolute) {
                try {
                  var response = await http.head(Uri.parse(element.urlToImage));
                  if (response.statusCode == HttpStatus.ok) {
                    if (count <= 20) {
                      count++;
                      log(element.title);
                      forPaginate.add(element);
                    } else {
                      break;
                    }
                  }
                } catch (e) {
                  log(e.toString());
                  continue;
                }
              }
            }
          }
          forBreaking.addAll(forPaginate);
          return emit(BreakingNewsState(
              breakingNews: forBreaking, errorMessage: "", isLoading: false));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
