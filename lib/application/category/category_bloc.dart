import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:news_api/services/api_services/category_api.dart';
import 'package:http/http.dart' as http;

part 'category_event.dart';
part 'category_state.dart';

List<Article> categories = [];

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategoryNews>((event, emit) async {
      emit(LoadingCategory());
      categories.clear();
      try {
        final fetch = await categoryFetch(event.anCategory);
        if (fetch.status != "null") {
          for (var element in fetch.articles) {
            if (categories.length < 10) {
              if (element.urlToImage != "null") {
                final anUri = Uri.tryParse(element.urlToImage);
                if (anUri != null && anUri.isAbsolute) {
                  try {
                    final response =
                        await http.get(Uri.parse(element.urlToImage));
                    if (response.statusCode == HttpStatus.ok) {
                      categories.add(element);
                    } else {
                      continue;
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                } else {
                  continue;
                }
              }
            }else{
              break;
            }
          }
          return emit(FetchCategory(fetched: categories));
        } else {
          return emit(FetchCategory(fetched: const []));
        }
      } catch (e) {
        log(e.toString());
      }
    });
    
  }
}