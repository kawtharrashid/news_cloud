import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_cloud/features/domain_layer/entities/article_entity.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_app_bar.dart';
import 'package:news_cloud/features/presentation_layer/widgets/custom_image.dart';
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
    // final buttonTextStyle =
    //     Theme.of(context).textButtonTheme.style?.textStyle?.resolve({});
    // log('Button font size: ${buttonTextStyle?.fontSize}');
    return Scaffold(
      appBar: CustomAppBar(title: article.sourceName ?? 'Article'),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomImage(imageUrl: article.image),
                if (article.image != null && article.image!.isNotEmpty)
                  const SizedBox(
                    height: 16,
                  ),
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
                            onPressed: () => _openArticle(url: article.url),
                            child: Text(article.sourceName!,
                                style: Theme.of(context).textTheme.labelSmall),
                          ),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
