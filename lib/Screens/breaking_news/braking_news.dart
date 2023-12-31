import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/single_article/an_article.dart';
import 'package:news_api/Screens/widgets/app_bar.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';

class BreakingNews extends StatelessWidget {
  const BreakingNews({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BreakingNewsBloc>(context).add(FetchBreaking());
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      body: BlocBuilder<BreakingNewsBloc, BreakingNewsState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            Future.delayed(const Duration(seconds: 2));
            return const Center(child: CircularProgressIndicator());
          } else if (state.breakingNews.isEmpty) {
            return const Center(
              child: Text("No data"),
            );
          } else {
            return CustomScrollView(
              slivers: [
              const AnAppBar(anTitle: "Breaking News"),
                SliverList.separated(
                  itemBuilder: (context, index) {
                    if (index == state.breakingNews.length - 1) {
                      BlocProvider.of<BreakingNewsBloc>(context)
                          .add(PaginationFetch());
                    }
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AnArticle(anArticle: state.breakingNews[index]),
                          )),
                      child: SizedBox(
                        height: kheight.height * 0.15,
                        child: SizedBox(
                          height: kheight.height * 0.1,
                          width: kWidth.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: state.breakingNews[index].urlToImage
                                    .toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  margin: EdgeInsets.only(
                                      left: kWidth.width * 0.007),
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
                                    state.breakingNews[index].title,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.breakingNews.length,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
