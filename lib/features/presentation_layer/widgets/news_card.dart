import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:news_cloud/core/routes/app_routes.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_image.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.articleEntity,
  });

  final ArticleEntity articleEntity;

  @override
  Widget build(BuildContext context) {
    final image = articleEntity.image;
    final isContentNotEmpty =
        articleEntity.content != null && articleEntity.content!.isNotEmpty;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          log(image.toString());
          Navigator.pushNamed(context, AppRoutes.articleDetails,
              arguments: articleEntity);
        },
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null && image.isNotEmpty)
                CustomImage(imageUrl: articleEntity.image)
              else
                const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                child: Column(
                  children: [
                    Text(articleEntity.title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    if (isContentNotEmpty)
                      Text(
                        articleEntity.content!,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
