import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/application/trending/trending_news_bloc.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TrendingNewsBloc>(context).add(FetchTrending());
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
   return BlocBuilder<TrendingNewsBloc, TrendingNewsState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingTrending:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case GetTrending:
          final fetchedTrends = 
          state as GetTrending;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Trending News"),
              ),
              body: SafeArea(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (index == fetchedTrends.trending.length - 1) {
                      BlocProvider.of<TrendingNewsBloc>(context)
                          .add(TrendingPagination());
                    }
                    return SizedBox(
                      height: kheight.height * 0.15,
                      child: SizedBox(
                        height: kheight.height * 0.1,
                        width: kWidth.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: fetchedTrends.trending[index].urlToImage.toString(),
                              imageBuilder: (context, imageProvider) => Container(
                                margin: EdgeInsets.only(left: kWidth.width * 0.007),
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
                                width: kWidth.width * 0.74,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    fetchedTrends.trending[index].title,
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
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: fetchedTrends.trending.length,
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Center(
                child: Text("Something went wrong"),
              ),
            );
        }
      },
    );
  }
}
