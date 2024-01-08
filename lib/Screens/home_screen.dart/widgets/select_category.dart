
import 'package:flutter/material.dart';
import 'package:news_api/models/categoy.dart';
import 'package:news_api/services/category_image.dart';

class CategoryHome extends StatelessWidget {
  const CategoryHome({
    super.key,
    required this.kheight,
    required this.theCategories,
    required this.kWidth,
  });

  final Size kheight;
  final List<CategoryAndName> theCategories;
  final Size kWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kheight.height * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, top: 5),
        child: ListView.separated(
          itemCount: theCategories.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => SizedBox(
            width: kWidth.width * 0.03,
            height: kheight.height * 0.001,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => categories[index],
                ),
              );
            },
            child: Stack(
              children: [
                Container(
                  width: kheight.width * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(theCategories[index].anImage),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        15,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: kheight.width * 0.4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.black45,
                  ),
                  child: Center(
                    child: Text(
                      theCategories[index].anName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
