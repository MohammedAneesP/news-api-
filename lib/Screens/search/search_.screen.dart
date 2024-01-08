import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/Screens/single_article/an_article.dart';
import 'package:news_api/application/search/new_search/new_search_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController anController = TextEditingController();

  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: 290,
                        child: TextField(
                          style:const TextStyle(color: Colors.white),
                          focusNode: myFocusNode,
                          autofocus: true,
                          controller: anController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
                        )),
                    BlocProvider(
                      create: (context) => NewSearchBloc(),
                      child: OutlinedButton(
                          onPressed: () {
                            myFocusNode.unfocus();

                            BlocProvider.of<NewSearchBloc>(context).add(
                                FetchingSearched(anQuery: anController.text));
                          },
                          child: const Text("Search")),
                    )
                  ],
                ),
                BlocBuilder<NewSearchBloc, NewSearchState>(
                    builder: (context, state) {
                  if (state is LoadingState) {
                    return const SizedBox(
                      height: 400,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is SearchedResult) {
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnArticle(
                                            anArticle:
                                                state.anSearchResult[index]),
                                      )),
                                  child: SizedBox(
                                    height: kheight.height * 0.15,
                                    child: SizedBox(
                                      height: kheight.height * 0.1,
                                      width: kWidth.width,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: state
                                                .anSearchResult[index]
                                                .urlToImage
                                                .toString(),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              width: kWidth.width * 0.3,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          SizedBox(
                                              width: kWidth.width * 0.6,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  state.anSearchResult[index]
                                                      .title,
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 18),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.anSearchResult.length),
                        );
                      },
                    );
                  } else {
                    return const SizedBox(
                      height: 400,
                      child: Center(child: Text("No data found")),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
