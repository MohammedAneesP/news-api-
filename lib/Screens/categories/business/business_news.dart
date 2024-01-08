import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/single_article/an_article.dart';
import 'package:news_api/Screens/widgets/app_bar.dart';
import 'package:news_api/application/category/category_bloc.dart';

class Business extends StatelessWidget {
  final String anCategory;
  const Business({super.key, required this.anCategory});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CategoryBloc>(context)
        .add(FetchCategoryNews(anCategory: anCategory));
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingCategory:
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: kheight.height,
                      child:const Center(child:  CircularProgressIndicator()),
                    ),
                  )
                ],
              ),
            );

          case FetchCategory:
            final anNews = state as FetchCategory;
            return Scaffold(
              body: SafeArea(
                  child: CustomScrollView(
                slivers: [
                   const AnAppBar(anTitle: "Business"),
                  SliverList.separated(
                    itemBuilder: (context, index) {
                      if (index == anNews.fetched.length - 1) {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(CategoryPagination(anCategory: anCategory));
                      }
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AnArticle(anArticle: anNews.fetched[index]),
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
                                  imageUrl: anNews.fetched[index].urlToImage
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
                                      anNews.fetched[index].title,
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
                    itemCount: anNews.fetched.length,
                  ),
                ],
              )),
            );

          default:
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: kheight.height,
                      child: const Text("Something Went wrong"),
                    ),
                  )
                ],
              ),
            );
        }
      },
    );
  }
}
