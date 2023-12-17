import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';
import 'package:news_api/models/categoy.dart';
import 'package:news_api/services/category_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrendingNewsBloc>(context).add(FetchTrending());
    final theCategories = theNameAndImage();
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "News Time",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoryHome(
                  kheight: kheight,
                  theCategories: theCategories,
                  kWidth: kWidth),
              SideHeading(
                  textOne: 'Breaking News',
                  textTwo: "View all",
                  anOnPressed: () {}),
              CarouselSlider(
                options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1),
                items: theCategories.map(
                  (i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.grey.withOpacity(0.1),
                              image: DecorationImage(
                                  image: AssetImage(i.anImage),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
              SideHeading(
                  textOne: "Trending News",
                  textTwo: "View all",
                  anOnPressed: () {}),
              LayoutBuilder(
                builder: (context, constraints) => ListView.builder(
                  itemCount: theCategories.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => SizedBox(
                    height: kheight.height * 0.15,
                    child: Container(
                      height: kheight.height * 0.1,
                      width: kWidth.width,
                      color: Colors.amber,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: kWidth.width * 0.25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        theCategories[index].anImage),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                              width: kWidth.width * 0.75,
                              child: const Text(
                                maxLines: 3,
                                "theb sihsdf ljhsgfhjkda adsdhkaghkjdas kagdhjasd kajhdsgbjhkluifiu sdiuhuid dsiuhgdsadhfkjuh adfuihuidf joilhjohf jkhlhahf hljlkjasdf luhhisadf,mnb",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SideHeading extends StatelessWidget {
  final String textOne;
  final String textTwo;
  final VoidCallback anOnPressed;
  const SideHeading({
    required this.textOne,
    required this.textTwo,
    required this.anOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textOne,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          TextButton(
              onPressed: anOnPressed,
              child: Text(
                textTwo,
                style: const TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              )),
        ],
      ),
    );
  }
}

class CategoryHome extends StatelessWidget {
  const CategoryHome({
    super.key,
    required this.kheight,
    required this.theCategories,
    required this.kWidth,
  });

  final Size kheight;
  final List<CategoryAndName> theCategories;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kheight.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 5),
        child: ListView.separated(
          itemCount: theCategories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: kWidth.width * 0.03,
            height: kheight.height * 0.001,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  width: kheight.width * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(theCategories[index].anImage),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: kheight.width * 0.4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                  ),
                  child: Center(
                    child: Text(
                      theCategories[index].anName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
