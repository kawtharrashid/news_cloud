import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/presentation_layer/cubit/saved_news_cubit/saved_news_cubit.dart';
import 'package:news_cloud/features/presentation_layer/widgets/bookmark_button.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_app_bar.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_image.dart';
import 'package:news_cloud/features/presentation_layer/widgets/show_alert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsView extends StatelessWidget {
  const ArticleDetailsView({super.key, required this.article});

  final ArticleEntity article;

  Future<void> _openArticle({String? url}) async {
    if (url == null || url.isEmpty) {
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    final bool hasImage = article.image != null && article.image!.isNotEmpty;
    return Scaffold(
      appBar: CustomAppBar(
        title: article.sourceName ?? 'Article',
        actions: [
          BlocBuilder<SavedNewsCubit, SavedNewsState>(
            buildWhen: (_, current) =>
                current is SavedNewsCubitLoaded ||
                current is SavedNewsCubitError,
            builder: (context, state) {
              final isSaved = state is SavedNewsCubitLoaded &&
                  state.savedArticles.any((savedArticle) {
                    ++i;
                    log(' Num of saved articles: ${i.toString()}');
                    return savedArticle.url == article.url;
                  });
              return BookmarkButton(
                isSaved: isSaved,
                onPressed: () async {
                  if (article.url == null || article.url!.isEmpty) {
                    return;
                  }
                  if (isSaved) {
                    await context
                        .read<SavedNewsCubit>()
                        .removeArticle(articleURL: article.url!);
                    log('Article removed from saved articles');
                  } else {
                    await context
                        .read<SavedNewsCubit>()
                        .saveArticle(article: article);
                    log('Article saved');
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasImage) ...[
                CustomImage(imageUrl: article.image),
                const SizedBox(height: 12),
              ] else
                const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    if (article.description != null)
                      Text(
                        article.description!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (article.sourceName != null) ...[
                          const Icon(
                            Icons.person,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              article.sourceName!,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          const SizedBox(width: 12),
                        ],
                        if (article.publishedAt != null) ...[
                          const Icon(
                            Icons.calendar_today,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            article.publishedAt != null
                                ? DateFormat('MMM d, yyyy ')
                                    .format(article.publishedAt!)
                                : 'Unknown date',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      article.content ?? 'No additional content available.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        if (article.sourceName == null || article.url == null)
                          const Text('No source available.')
                        else
                          Row(
                            children: [
                              Text(
                                'Read more on ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextButton(
                                onPressed: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (context) => CustomAlertDialog(
                                      title: const Text('Open Article'),
                                      content:
                                          'Do you want to open the article in your browser?',
                                      okButtonText: 'Open',
                                      onPressedCancel: () =>
                                          Navigator.of(context).pop(),
                                      onPressedOK: () async {
                                        Navigator.of(context).pop();
                                        await _openArticle(url: article.url);
                                      },
                                    ),
                                  );
                                },
                                child: Text(article.sourceName!,
                                    style:
                                        Theme.of(context).textTheme.labelSmall),
                              ),
                            ],
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
