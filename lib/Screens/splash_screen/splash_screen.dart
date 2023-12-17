import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_api/Screens/home_screen.dart/home_screen.dart';

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
    return Scaffold(
      body: Center(
        child: CircleAvatar(
          child: Icon(CupertinoIcons.news,color: Colors.white,),
        ),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(
    const  Duration(seconds: 5),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}
