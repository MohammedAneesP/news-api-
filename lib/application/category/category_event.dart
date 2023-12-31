part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class FetchCategoryNews extends CategoryEvent {
  final String anCategory;
  FetchCategoryNews({required this.anCategory});
}

class CatogoryPagination extends CategoryEvent {
  final String anCategory;
  CatogoryPagination({required this.anCategory});
}
