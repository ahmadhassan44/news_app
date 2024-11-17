
import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';

@dao
abstract class ArticleDao{
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insertArticle(ArticleModel article);
  @Query("SELECT * FROM articles")
  Future<List<ArticleModel>> getArticles();
  @Query("DELETE FROM articles WHERE url=:url OR title=:title OR description=:description")
  Future<void> deleteArticle(ArticleModel article);
}