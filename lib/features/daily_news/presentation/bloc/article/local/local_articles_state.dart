import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class LocalArticlesState {
  final List<ArticleEntity>? articles;
  const LocalArticlesState({this.articles});
}
class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}
class LocalArticlesLoaded extends LocalArticlesState {
  const LocalArticlesLoaded(List<ArticleEntity> articles) : super(articles: articles);
}