import 'package:flutter/material.dart';
import 'package:news_cloud/core/constants.dart';
import 'category_card.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: kCategories.length,
        itemBuilder: (context, index) {
          final category = kCategories[index];

          return CategoryCard(
            category: category,
          );
        },
      ),
    );
  }
}
