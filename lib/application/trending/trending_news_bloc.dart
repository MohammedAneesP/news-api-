import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/trending_api.dart';
import 'package:http/http.dart' as http;

part 'trending_news_event.dart';
part 'trending_news_state.dart';

List<Article> trending = [];

class TrendingNewsBloc extends Bloc<TrendingNewsEvent, TrendingNewsState> {
  TrendingNewsBloc() : super(TrendingNewsInitial()) {
    on<FetchTrending>((event, emit) async {
      try {
        emit(LoadingTrending());
        final newses = await fetchingNews();
        if (newses.status != "null") {
          trending.clear();
          final artics = newses.articles;

          int count = 0;
          for (var element in artics) {
            if (element.urlToImage != "null") {
              Uri? uri = Uri.tryParse(element.urlToImage);
              if (uri != null && uri.isAbsolute) {
                try {
                  var response = await http.head(Uri.parse(element.urlToImage));
                  if (response.statusCode == HttpStatus.ok) {
                    if (count < 10) {
                      count++;
                      trending.add(element);
                    } else {
                      break;
                    }
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
          return emit(GetTrending(trending: trending));
        } else {
          return emit(GetTrending(trending: const []));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    on<TrendingPagination>((event, emit) async {
      try {
        final fetchTrends = await fetchingNews();
        if (fetchTrends.status != "null") {
          List<Article> anTrending = [];
          int count = 0;
          for (var element in fetchTrends.articles) {
            if (element.urlToImage != "null" &&
                !trending.any((news) => news.title == element.title)) {
              Uri? url = Uri.tryParse(element.urlToImage);
              if (url != null && url.isAbsolute) {
                var anResponse = await http.head(Uri.parse(element.urlToImage));
                if (anResponse.statusCode == HttpStatus.ok) {
                  if (count < 10) {
                    count++;
                    anTrending.add(element);
                    log(element.title.toString());
                  } else {
                    break;
                  }
                } else {
                  continue;
                }
              } else {
                continue;
              }
            } else {
              continue;
            }
          }
          trending.addAll(anTrending);
          return emit(GetTrending(trending: trending));
        } else {
          return emit(GetTrending(trending: const []));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
