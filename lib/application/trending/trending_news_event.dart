part of 'trending_news_bloc.dart';

@immutable
sealed class TrendingNewsEvent {}

class FetchTrending extends TrendingNewsEvent{}
