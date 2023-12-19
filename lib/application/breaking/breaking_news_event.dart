part of 'breaking_news_bloc.dart';

@immutable
sealed class BreakingNewsEvent {}

class FetchBreaking extends BreakingNewsEvent{}
