import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/application/category/category_bloc.dart';

class Entertainmet extends StatelessWidget {
  final String anCategory;
  const Entertainmet({super.key, required this.anCategory});

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
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case FetchCategory:
            final anLoaded = state as FetchCategory;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Entertainment"),
              ),
              body: ListView.separated(
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
                                  anLoaded.fetched[index].urlToImage.toString(),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                margin:
                                    EdgeInsets.only(left: kWidth.width * 0.007),
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
                                  anLoaded.fetched[index].title,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: anLoaded.fetched.length),
            );

          default:
            return const Scaffold(
              body: Center(
                child: Text("No Data"),
              ),
            );
        }
      },
    );
  }
}
