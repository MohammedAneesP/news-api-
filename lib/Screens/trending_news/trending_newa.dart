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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Trending News",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
      body: BlocBuilder<TrendingNewsBloc, TrendingNewsState>(
        builder: (context, state) {
          return ListView.separated(
            physics: const ClampingScrollPhysics(),
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
                        imageUrl:
                            state.trending[index].urlToImage.toString(),
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
            separatorBuilder: (context, index) =>const Divider(),
            itemCount: state.trending.length,
          );
        },
      ),
    );
  }
}
