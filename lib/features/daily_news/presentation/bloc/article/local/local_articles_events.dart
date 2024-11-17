import '../../../../domain/entities/article.dart';

abstract class LocalArticlesEvents  {
  const LocalArticlesEvents();
}
class LocalArticlesLoad extends LocalArticlesEvents {
  const LocalArticlesLoad();
}
class LocalArticleDeleted extends LocalArticlesEvents {
  final ArticleEntity article;
  const LocalArticleDeleted(this.article);
}
