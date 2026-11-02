import 'package:flutter/material.dart';
import 'package:news_cloud/core/config/extension.dart';
import 'package:shimmer/shimmer.dart';

class NewsListShimmer extends StatelessWidget {
  const NewsListShimmer({super.key});

  Widget _placeholder({
    double? width,
    required double height,
  }) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Shimmer.fromColors(
            baseColor: context.shimmerBaseColor,
            highlightColor: context.shimmerHighlightColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _placeholder(height: 200),
                const SizedBox(height: 12),
                _placeholder(height: 20),
                const SizedBox(height: 8),
                _placeholder(width: 250, height: 20),
                const SizedBox(height: 12),
                _placeholder(height: 14),
                const SizedBox(height: 6),
                _placeholder(height: 14),
              ],
            ),
          ),
        ),
        childCount: 5,
      ),
    );
  }
}
