import 'package:flutter/material.dart';
import 'package:news_cloud/core/routes/app_routes.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_image.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    super.key,
    required this.articleEntity,
  });

  final ArticleEntity articleEntity;

  @override
  Widget build(BuildContext context) {
    final image = articleEntity.image;
    final  isContentNotEmpty =
        articleEntity.content != null && articleEntity.content!.isNotEmpty;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.articleDetails,
              arguments: articleEntity);
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null && image.isNotEmpty)
                Column(
                  children: [
                    CustomImage(
                      imageUrl: articleEntity.image!,
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              else
                const SizedBox.shrink(),
              Text(
                articleEntity.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              if (isContentNotEmpty)
                Text(
                  articleEntity.content!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
