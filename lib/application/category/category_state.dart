part of 'category_bloc.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class FetchCategory extends CategoryState {
  final List<dynamic> fetched;
  FetchCategory({required this.fetched});
}

class LoadingCategory extends CategoryState{}