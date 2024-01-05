part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {}

class FetchCategoryNews extends CategoryEvent {
  final String anCategory;
  FetchCategoryNews({required this.anCategory});
}

class CategoryPagination extends CategoryEvent {
  final String anCategory;
  CategoryPagination({required this.anCategory});
}
