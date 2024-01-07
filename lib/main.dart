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
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.black),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 22, color: Colors.white),
              bodyLarge: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          scaffoldBackgroundColor:const Color.fromARGB(135, 32, 31, 31),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
             backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.white,
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
