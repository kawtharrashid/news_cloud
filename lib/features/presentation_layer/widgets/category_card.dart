import 'package:flutter/material.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';
import 'package:news_cloud/core/routes/app_routes.dart';
import 'package:news_cloud/features/data_layer/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.category,
            arguments: category.category,
          );
        },
        child: SizedBox(
          height: 50,
          width: 140,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(category.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                category.category,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: AppColors.darkTextPrimary),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
