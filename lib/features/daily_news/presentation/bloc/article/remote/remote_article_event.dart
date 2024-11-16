abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetArticles extends RemoteArticleEvent {
  const GetArticles();
}
class OpenArticle extends RemoteArticleEvent{
  const OpenArticle();
}
