part of 'trending_news_bloc.dart';

class TrendingNewsState {
  final bool isLoading;
  final List<dynamic> trending;
  final String errorMessage;
  TrendingNewsState({required this.isLoading, required this.trending,required this.errorMessage});
}

class TrendingNewsInitial extends TrendingNewsState {
  TrendingNewsInitial() : super(isLoading: true, trending: [],errorMessage: "");
}
