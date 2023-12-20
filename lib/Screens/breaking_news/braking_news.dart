import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/application/breaking/breaking_news_bloc.dart';

class BreakingNews extends StatefulWidget {
  const BreakingNews({super.key});

  @override
  State<BreakingNews> createState() => _BreakingNewsState();
}

final anController = ScrollController();

class _BreakingNewsState extends State<BreakingNews> {
  @override
  void initState() {
    anController.addListener(() {
      if (anController.position.maxScrollExtent == anController.offset) {
        BlocProvider.of<BreakingNewsBloc>(context).add(FetchBreaking());
        log("andi");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BreakingNewsBloc>(context).add(FetchBreaking());
    final kheight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: const Text(
          "Breaking News",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
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
            // Future.delayed(
            // const  Duration(seconds: 2),
            //   () => showDialog(
            //     context: context,
            //     builder: (context) =>const Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // );
            // Navigator.pop(context);
            return ListView.separated(
              controller: anController,
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
                              state.breakingNews[index].urlToImage.toString(),
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
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 25,
            );
          }
        },
      ),
    );
  }
}
