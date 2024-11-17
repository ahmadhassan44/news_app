import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/domain/usecases/delete_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_events.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_state.dart';

final Logger _logger = Logger('LocalArticlesBloc');

class LocalArticlesBloc extends Bloc<LocalArticlesEvents, LocalArticlesState> {
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  final DeleteArticleUsecase _deleteArticleUsecase;

  LocalArticlesBloc(this._getSavedArticlesUsecase, this._deleteArticleUsecase) : super(const LocalArticlesLoading()) {
    on<LocalArticlesLoad>(_onGetSavedArticles);
    on<LocalArticleDeleted>(_onDeleteArticle);
  }

  void _onGetSavedArticles(LocalArticlesLoad event, Emitter<LocalArticlesState> emit) async {
    _logger.info("LocalArticlesLoad event received");
    emit(const LocalArticlesLoading());
    try {
      final articles = await _getSavedArticlesUsecase();
      _logger.info("Local Articles: $articles");
      emit(LocalArticlesLoaded(articles));
    } catch (e) {
      _logger.severe("Failed to load local articles", e);
    }
  }

  void _onDeleteArticle(LocalArticleDeleted event, Emitter<LocalArticlesState> emit) async {
    _logger.info("LocalArticleDeleted event received");
    try {
      await _deleteArticleUsecase.call(params: event.article);
      final articles = await _getSavedArticlesUsecase();
      _logger.info("Local Articles after deletion: $articles");
      emit(LocalArticlesLoaded(articles));
    } catch (e) {
      _logger.severe("Failed to delete local article", e);
    }
  }
}