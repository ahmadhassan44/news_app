import '../../../../domain/entities/article.dart';

abstract class ArticleDetailsEvent{
  const ArticleDetailsEvent();
}
class ArticleSavedEvent extends ArticleDetailsEvent {
  final ArticleEntity article;

  const ArticleSavedEvent(this.article);
}
class ArticleUnsavedEvent extends ArticleDetailsEvent{
  const ArticleUnsavedEvent();
}