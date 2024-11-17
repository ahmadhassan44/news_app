import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_bloc.dart';
import 'package:news_app/features/daily_news/presentation/pages/details/article_details.dart';

import '../bloc/article/local/local_articles_events.dart';

class SavedArticleTile extends StatelessWidget {
  final ArticleEntity article;

  const SavedArticleTile({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Logger log=Logger('ArticleTile');
        log.info('ArticleTile: Article clicked');
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => ArticleDetails(article: article)
            )
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: EdgeInsets.all(width * 0.01),
        width: double.infinity,
        height: height * 0.25,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.3,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl:
                  article.urlToImage ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/placeholder-image.jpg'),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      article.description ?? 'No Description',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child:
                    GestureDetector(
                      onTap: () {
                        Logger log=Logger('ArticleTile');
                        log.info('ArticleTile: Article deleted');
                        context.read<LocalArticlesBloc>().add(LocalArticleDeleted(article));
                        context.read<LocalArticlesBloc>().add(const LocalArticlesLoad());
                        log.info("control is here");
                      },
                      child: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
