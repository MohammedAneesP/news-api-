import 'package:news_api/models/categoy.dart';

List<CategoryAndName> theNameAndImage() {
  List<CategoryAndName> anList = [];
  
  final List<String> categoryName = [
    "Business",
    "Entertainmet",
    "Health",
    "News",
    "Science",
    "Sports"
  ];
  for (var i = 0; i < images.length; i++) {
    final anData = CategoryAndName(anImage: images[i], anName: categoryName[i]);
    anList.add(anData);
  }
  return anList;
}
List<String> images = [
    "assets/business.jpg",
    "assets/entertainment.jpg",
    "assets/health.webp",
    "assets/news.jpg",
    "assets/science.webp",
    "assets/sports.avif",
  ];