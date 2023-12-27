part of 'new_search_bloc.dart';

@immutable
abstract class NewSearchState {}

class NewSearchInitial extends NewSearchState {}

class SearchedResult extends NewSearchState {
  final List<dynamic> anSearchResult;

  SearchedResult({required this.anSearchResult});
}

class LoadingState extends NewSearchState {}
