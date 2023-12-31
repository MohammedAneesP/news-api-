import 'package:news_api/Screens/categories/business/business_news.dart';
import 'package:news_api/Screens/categories/entertainment/entertainment.dart';
import 'package:news_api/Screens/categories/health/health_news.dart';
import 'package:news_api/Screens/categories/science/science_news.dart';
import 'package:news_api/Screens/categories/sports/sports.dart';
import 'package:news_api/models/categoy.dart';

List<CategoryAndName> theNameAndImage() {
  List<CategoryAndName> anList = [];

  final List<String> categoryName = [
    "Business",
    "Entertainmet",
    "Health",
    "Science",
    "Sports"
  ];
  for (var i = 0; i < images.length; i++) {
    final anData = CategoryAndName(anImage: images[i], anName: categoryName[i]);
    anList.add(anData);
  }
  return anList;
}

final List<dynamic> categories = [
  const Business(),
  const Entertainmet(anCategory: "entertainment"),
  const Health(),
  const Sceince(),
  const Sports(),
];

List<String> images = [
  "assets/business.jpg",
  "assets/entertainment.jpg",
  "assets/health.webp",
  "assets/science.webp",
  "assets/sports.avif",
];
