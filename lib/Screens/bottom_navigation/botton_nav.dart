import 'package:flutter/material.dart';
import 'package:news_api/Screens/home_screen.dart/home_screen.dart';
import 'package:news_api/Screens/search/search_.screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  final iconList = [
    const Icon(Icons.home),
    const Icon(Icons.search),
  ];
  int pageIndex = 0;
  final screens = [
    const HomeScreen(),
     SearchScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        currentIndex: pageIndex,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), tooltip: "Home", label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              tooltip: "Search",
              label: "Search"),
        ],
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
      ),
      body: screens[pageIndex],
    );
  }
}
