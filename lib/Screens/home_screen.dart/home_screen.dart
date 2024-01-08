import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/breaking_news/braking_news.dart';
import 'package:news_api/Screens/home_screen.dart/widgets/select_category.dart';
import 'package:news_api/Screens/home_screen.dart/widgets/side_heading.dart';
import 'package:news_api/Screens/single_article/an_article.dart';
import 'package:news_api/Screens/trending_news/trending_newa.dart';
import 'package:news_api/Screens/widgets/app_bar.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';
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
      body: CustomScrollView(
        slivers: [
          const AnAppBar(anTitle: "News Time"),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CategoryHome(
                    kheight: kheight,
                    theCategories: theCategories,
                    kWidth: kWidth),
                SideHeading(
                  textOne: 'Breaking News',
                  textTwo: "View all",
                  anOnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BreakingNews(),
                      ),
                    );
                  },
                ),
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
                      final breakingList = List.generate(
                          6, (index) => state.breakingNews[index]);
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
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AnArticle(anArticle: i),
                                        ));
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: i.urlToImage,
                                    imageBuilder: (context, imageProvider) {
                                      return Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15))),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            height: kheight.height * .07,
                                            width: kWidth.width,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15)),
                                              color: Colors.black54,
                                            ),
                                            child: Center(
                                              child: Text(i.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                BlocBuilder<TrendingNewsBloc, TrendingNewsState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case LoadingTrending:
                        return SizedBox(
                          height: kheight.height * .2,
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      case GetTrending:
                        final fetchedTrend = state as GetTrending;
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              const Divider(),
                          padding: const EdgeInsets.fromLTRB(8, 0, 5, 0),
                          itemCount: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AnArticle(
                                      anArticle:
                                          fetchedTrend.trending[index]),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15))),
                                height: kheight.height * 0.15,
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: fetchedTrend
                                          .trending[index].urlToImage
                                          .toString(),
                                      imageBuilder:
                                          (context, imageProvider) =>
                                              Container(
                                        height: kheight.height * 0.148,
                                        width: kWidth.width * 0.27,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              const BorderRadius.all(
                                                  Radius.circular(15)),
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
                                      width: kWidth.width * 0.6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          fetchedTrend.trending[index].title,
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                      default:
                        return SizedBox(
                          height: kheight.height * .05,
                          child:
                              const Center(child: Text("Something went wrong")),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

