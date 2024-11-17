import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleDetails extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetails({super.key, required this.article});

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  bool _isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(widget.article.title ?? "News Article"),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isSaved = !_isSaved;
                });
              },
              icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: widget.article.urlToImage ??
                          'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/placeholder-image.jpg'),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  widget.article.title ?? "Title",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,height: 1),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  widget.article.content ?? "Description",
                  style: TextStyle(fontSize: 18, height:1.5,color: Colors.black54),
                ),
              ],
            ),
          ),
        ));
  }
}
