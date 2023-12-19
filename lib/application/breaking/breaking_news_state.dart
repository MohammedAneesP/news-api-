part of 'breaking_news_bloc.dart';

class BreakingNewsState {
  final List<dynamic> breakingNews;
  final bool isLoading;
  final String errorMessage;
  BreakingNewsState({
    required this.breakingNews,
    required this.errorMessage,
    required this.isLoading,
  });
}

class BreakingNewsInitial extends BreakingNewsState {
  BreakingNewsInitial()
      : super(
          breakingNews: [],
          errorMessage: "",
          isLoading: true,
        );
}
