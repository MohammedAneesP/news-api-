import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/bottom_navigation/botton_nav.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    goto();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircleAvatar(
          child: Icon(CupertinoIcons.news,color: Colors.white,),
        ),
      ),
    );
  }

  Future<void> goto() async {
    BlocProvider.of<TrendingNewsBloc>(context).add(FetchTrending());
    BlocProvider.of<BreakingNewsBloc>(context).add(FetchBreaking());
    await Future.delayed(
    const  Duration(seconds: 5),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
  }
}
