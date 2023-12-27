part of 'new_search_bloc.dart';

@immutable
sealed class NewSearchEvent {}

class LoadingProgress extends NewSearchEvent {}

class FetchingSearched extends NewSearchEvent {
  final String anQuery;

  FetchingSearched({required this.anQuery});
}
