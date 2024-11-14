import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

class ArticleRepoImpl implements ArticleRepo{
  @override
  Future<DataState<List<ArticleModel>>> getArticles() {
    throw UnimplementedError();
  }

}