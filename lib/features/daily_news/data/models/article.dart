import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

@Entity(tableName: 'articles', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleModel({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "",
      urlToImage: map['urlToImage'] ?? "",
      publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? "",
    );
  }
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      author:entity.author ?? "",
      title: entity.title ?? "",
      description: entity.description ?? "",
      url: entity.url?? "",
      urlToImage: entity.urlToImage ?? "",
      publishedAt: entity.publishedAt ?? "",
      content: entity.content ?? "",

    );
  }
}
