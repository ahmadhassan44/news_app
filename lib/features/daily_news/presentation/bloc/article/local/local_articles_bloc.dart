import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_events.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_state.dart';


final Logger _logger = Logger('LocalArticlesBloc');
class LocalArticlesBloc extends Bloc<LocalArticlesEvents,LocalArticlesState>{
  final GetSavedArticlesUsecase _getSavedArticlesUsecase;
  LocalArticlesBloc(this._getSavedArticlesUsecase):super(const LocalArticlesLoading()){
    on<LocalArticlesLoad>(_onGetSavedArticles);
  }
  void _onGetSavedArticles(LocalArticlesLoad event, Emitter<LocalArticlesState> emit) async {
    _logger.info("LocalArticlesLoad event received");
    final articles = await _getSavedArticlesUsecase();
    _logger.info("Local Articles: $articles");
    emit(LocalArticlesLoaded(articles));
  }
}