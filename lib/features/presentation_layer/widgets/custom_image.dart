import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_cloud/core/config/theme_data/app_colors.dart';

import 'package:news_cloud/core/constants.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
            ),
            child: SizedBox(
              height: 200,
              child: Center(
                child: LoadingAnimationWidget.hexagonDots(
                  size: 40,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
