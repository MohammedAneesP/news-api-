part of 'trending_news_bloc.dart';

class TrendingNewsState {
  final bool isLoading;
  final List<dynamic> trending;
  TrendingNewsState({required this.isLoading, required this.trending});
}

class TrendingNewsInitial extends TrendingNewsState {
  TrendingNewsInitial() : super(isLoading: true, trending: []);
}
