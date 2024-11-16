
import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao{
  @Insert()
  Future<void> insertArticle(ArticleModel article);
  @Query("SELECT * FROM articles")
  Future<List<ArticleModel>> getArticles();
  @delete
  Future<void> deleteArticle(ArticleModel article);
}