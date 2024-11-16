import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {
  final GetArticleUsecase _getArticles;
  RemoteArticleBloc(this._getArticles) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
    on<OpenArticle>(onOpenArticle);
  }
  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticles();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesLoaded(dataState.data!));
    } else {
      emit(RemoteArticlesLoadingFailed(dataState.error!));
    }
  }
  void onOpenArticle(OpenArticle event, Emitter<RemoteArticleState> emit){

  }
}
