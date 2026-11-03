import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_cloud/core/config/extension.dart';
import 'package:shimmer/shimmer.dart';

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
                child: Shimmer.fromColors(
                  baseColor: context.shimmerBaseColor,
                  highlightColor: context.shimmerHighlightColor,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                  ),
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
