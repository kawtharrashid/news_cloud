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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xffF2F4F3),
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
                Text(article.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
                const SizedBox(height: 8),
                if (article.description != null)
                  Text(article.description!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (article.sourceName != null) ...[
                      const Icon(Icons.person, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          article.sourceName!,
                          style: const TextStyle(color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    if (article.publishedAt != null) ...[
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        article.publishedAt != null
                            ? DateFormat('MMM d, yyyy, h:mm a')
                                .format(article.publishedAt!)
                            : 'Unknown date',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                Text(
                  article.content ?? 'No additional content available.',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    if (article.sourceName == null || article.url == null)
                      const Text('No source available.')
                    else
                      Row(
                        children: [
                          const Text('Read more on '),
                          InkWell(
                            onTap: () => _openArticle(url: article.url),
                            child: Text(
                              article.sourceName!,
                              style: const TextStyle(
                                color: Colors.amber,
                                shadows: [
                                  Shadow(
                                      color: Colors.black26,
                                      offset: Offset(.5, 1),
                                      blurRadius: 3)
                                ],
                              ),
                            ),
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
