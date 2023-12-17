import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'trending_news_event.dart';
part 'trending_news_state.dart';

class TrendingNewsBloc extends Bloc<TrendingNewsEvent, TrendingNewsState> {
  TrendingNewsBloc() : super(TrendingNewsInitial()) {
    on<FetchTrending>((event, emit) async {
      final urlParse = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=512f3063fb9a4a3a8bc1e453f1eb4f70");
      var anResponse = await http.get(urlParse);
      print(anResponse.body);
    });
  }
}
