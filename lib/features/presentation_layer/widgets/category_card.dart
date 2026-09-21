import 'package:flutter/material.dart';
import 'package:news_cloud/core/routes/app_routes.dart';
import 'package:news_cloud/features/data_layer/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.category,
            arguments: category.category,
          );
        },
        child: SizedBox(
          height: 85,
          width: 160,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(category.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                category.category,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
