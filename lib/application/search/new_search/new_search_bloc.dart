import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/search_api.dart';
import 'package:http/http.dart' as http;

part 'new_search_event.dart';
part 'new_search_state.dart';

List<Article> searchArticle = [];

class NewSearchBloc extends Bloc<NewSearchEvent, NewSearchState> {
  NewSearchBloc() : super(NewSearchInitial()) {
    on<FetchingSearched>((event, emit) async {
      emit(LoadingState());

      try {
        log("called");
        searchArticle.clear();
        News searchFetch;

        if (event.anQuery.isEmpty) {
          searchFetch = await fetchSearched("india");
        } else {
          searchFetch = await fetchSearched(event.anQuery);
        }
        if (searchFetch.status == "null") {
          emit(SearchedResult(anSearchResult: const []));
        } else {
          int count = 0;
          if (searchArticle.length < 20) {
            for (var element in searchFetch.articles) {
              if (element.urlToImage != "null") {
                Uri? anUrl = Uri.tryParse(element.urlToImage);
                if (anUrl != null && anUrl.isAbsolute) {
                  try {
                    var anResponse =
                        await http.head(Uri.parse(element.urlToImage));
                    if (anResponse.statusCode == HttpStatus.ok) {
                      if (count < 20) {
                        count++;
                        searchArticle.add(element);
                      } else {
                        break;
                      }
                    }
                  } catch (e) {
                    log(e.toString());
                    continue;
                  }
                }
              } else {
                continue;
              }
            }
          }

          log(searchArticle.length.toString());
          emit(SearchedResult(anSearchResult: searchArticle));
        }
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
