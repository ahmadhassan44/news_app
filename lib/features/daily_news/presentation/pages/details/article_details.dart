import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleDetails extends StatefulWidget {
  final ArticleEntity article;
  const ArticleDetails({super.key,  required this.article});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  bool _isSaved=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title ?? "News Article"),
      ),

    );

  }
}
