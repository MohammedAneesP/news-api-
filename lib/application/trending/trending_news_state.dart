part of 'trending_news_bloc.dart';

@immutable
sealed class TrendingNewsState {}

class TrendingNewsInitial extends TrendingNewsState {}

class GetTrending extends TrendingNewsState{
  final List<dynamic>trending;
  GetTrending({required this.trending});
}

class LoadingTrending extends TrendingNewsState{}
