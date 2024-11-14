import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

abstract class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioError? error;

  const RemoteArticleState({this.articles, this.error});

  @override
  List<Object?> get props => [articles, error];
}

class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

class RemoteArticlesLoaded extends RemoteArticleState {
  const RemoteArticlesLoaded(List<ArticleEntity> articles) : super(articles: articles);
}

class RemoteArticlesLoadingFailed extends RemoteArticleState{
  const RemoteArticlesLoadingFailed(DioError dioerror):super(error: dioerror);
}