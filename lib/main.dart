import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/splash_screen/splash_screen.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';
import 'package:news_api/application/category/category_bloc.dart';
import 'package:news_api/application/search/new_search/new_search_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TrendingNewsBloc()),
        BlocProvider(create: (context) => BreakingNewsBloc()),
        BlocProvider(create: (context) => NewSearchBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 22),
              bodyLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w600)),
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.grey[200],
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
