
import 'package:flutter/material.dart';

class AnAppBar extends StatelessWidget {
  final String anTitle;
  const AnAppBar({
    required this.anTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      floating: true,
      snap: true,
      title: Text(
       anTitle
      ),
    );
  }
}