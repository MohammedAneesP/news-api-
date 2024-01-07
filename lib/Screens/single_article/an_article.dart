import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/models/trending_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AnArticle extends StatelessWidget {
  final Article anArticle;
  const AnArticle({
    super.key,
    required this.anArticle,
  });

  @override
  Widget build(BuildContext context) {
    final anSize = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CachedNetworkImage(
                  imageUrl: anArticle.urlToImage,
                  imageBuilder: (context, imageProvider) => Stack(
                    children: [
                      Container(
                        height: anSize.height * 0.4,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context)
                              .scaffoldBackgroundColor
                              .withOpacity(0.8),
                          child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Text(
                  anArticle.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(anArticle.description),
                TextButton(
                  onPressed: () async {
                    Uri url = Uri.parse(anArticle.url);
                    if (!await launchUrl(url)) {
                      throw Exception("could not launch");
                    }
                  },
                  child: const Text("Viewmore"),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
