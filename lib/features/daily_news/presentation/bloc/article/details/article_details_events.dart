abstract class ArticleDetailsEvent{
  const ArticleDetailsEvent();
}
class ArticleSavedEvent extends ArticleDetailsEvent{
  const ArticleSavedEvent();
}
class ArticleUnsavedEvent extends ArticleDetailsEvent{
  const ArticleUnsavedEvent();
}