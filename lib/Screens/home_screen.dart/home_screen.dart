import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/breaking_news/braking_news.dart';
import 'package:news_api/Screens/trending_news/trending_newa.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';
import 'package:news_api/models/categoy.dart';
import 'package:news_api/services/category_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrendingNewsBloc>(context).add(FetchTrending());
    BlocProvider.of<BreakingNewsBloc>(context).add(FetchBreaking());
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            CategoryHome(
                kheight: kheight, theCategories: theCategories, kWidth: kWidth),
            SideHeading(
                textOne: 'Breaking News',
                textTwo: "View all",
                anOnPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreakingNews(),
                      ));
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pop(context);
                }),
            BlocBuilder<BreakingNewsBloc, BreakingNewsState>(
              builder: (context, state) {
                if (state.isLoading == true) {
                  return const Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state.breakingNews.isEmpty) {
                  return SizedBox(
                    height: kheight.height * 0.2,
                    child: const Center(
                      child: Text("Something Went Wrong"),
                    ),
                  );
                } else {
                  final breakingList =
                      List.generate(6, (index) => state.breakingNews[index]);
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: kheight.height * .25,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1),
                    items: breakingList.map(
                      (i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () {},
                              child: CachedNetworkImage(
                                imageUrl: i.urlToImage,
                                imageBuilder: (context, imageProvider) {
                                  return Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        height: kheight.height * .07,
                                        width: kWidth.width,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15)),
                                          color: Colors.black54,
                                        ),
                                        child: Center(
                                          child: Text(i.title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  );
                }
              },
            ),
            SideHeading(
                textOne: "Trending News",
                textTwo: "View all",
                anOnPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrendingNews(),
                      ));
                }),
            LayoutBuilder(
              builder: (context, constraints) =>
                  BlocBuilder<TrendingNewsBloc, TrendingNewsState>(
                builder: (context, state) {
                  if (state.isLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.trending.isEmpty) {
                    return Center(
                      child: Text(state.errorMessage),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: kheight.height * 0.15,
                          child: SizedBox(
                            height: kheight.height * 0.1,
                            width: kWidth.width,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: state.trending[index].urlToImage
                                      .toString(),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: kWidth.width * 0.25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                SizedBox(
                                    width: kWidth.width * 0.75,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.trending[index].title,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
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
