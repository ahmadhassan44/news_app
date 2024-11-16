abstract class RemoteArticleEvent {
  const RemoteArticleEvent();
}

class GetRemoteArticles extends RemoteArticleEvent {
  const GetRemoteArticles();
}
class OpenArticle extends RemoteArticleEvent{
  const OpenArticle();
}
class GetLocalArticles extends RemoteArticleEvent{
  const GetLocalArticles();
}
