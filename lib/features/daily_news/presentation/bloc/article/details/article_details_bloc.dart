import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_events.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_states.dart';

class ArticleDetailsBloc extends Bloc<ArticleDetailsEvent,ArticleDetailsState>{
  ArticleDetailsBloc():super(const ArticleUnsavedState()) {
    on<ArticleSavedEvent>(_onArticleSave);
    on<ArticleUnsavedEvent>(_onArticleUnsave);
  }
  void _onArticleSave(ArticleSavedEvent event, Emitter<ArticleDetailsState> emit) {
    emit(const ArticleSavedState());
  }
  void _onArticleUnsave(ArticleUnsavedEvent event, Emitter<ArticleDetailsState> emit) {
    emit(const ArticleUnsavedState());
  }
}