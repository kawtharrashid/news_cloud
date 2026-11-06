import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_cloud/features/presentation_layer/cubit/saved_news_cubit/saved_news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/widgets/news_card.dart';
import 'package:news_cloud/features/presentation_layer/widgets/news_list_shimmer.dart';
import 'package:news_cloud/features/presentation_layer/widgets/show_alert_dialog.dart';

class SavedArticlesView extends StatelessWidget {
  const SavedArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Articles'),
      ),
      body: BlocBuilder<SavedNewsCubit, SavedNewsState>(
        builder: (context, state) {
          if (state is SavedNewsCubitLoading) {
            return const NewsListShimmer();
          }
          if (state is SavedNewsCubitError) {
            return const CustomAlertDialog(
              title: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Error'),
                ],
              ),
              content:
                  'Something went wrong while fetching saved articles. Please try again later.',
            );
          }
          if (state is SavedNewsCubitLoaded) {
            if (state.savedArticles.isEmpty) {
              return const Center(child: Text('No saved articles yet.'));
            }
            return ListView.builder(
              itemCount: state.savedArticles.length,
              itemBuilder: (context, index) {
                final article = state.savedArticles[index];
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: const Text('Remove Article'),
                        content:
                            'Are you sure you want to remove this article from saved articles?',
                        onPressedOK: () {
                          context.read<SavedNewsCubit>().removeArticle(
                                articleURL: article.url!,
                              );
                          Navigator.of(context).pop();
                        },
                        onPressedCancel: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (context) => AlertDialog(
                    //     title: const Text('Remove Article'),
                    //     content: const Text(
                    //         'Are you sure you want to remove this article from saved articles?'),
                    //     actions: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         child: const Text('Cancel'),
                    //       ),
                    //       TextButton(
                    //         onPressed: () {
                    //           context
                    //               .read<SavedNewsCubit>()
                    //               .removeArticle(index);
                    //           Navigator.of(context).pop();
                    //         },
                    //         child: const Text('Remove'),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  },
                  child: NewsCard(
                    articleEntity: article,
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
