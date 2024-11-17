import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/database/news_app_database.dart';
import 'package:news_app/features/daily_news/data/repos_impl/article_repo_impl.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_saved_articles.dart';
import 'package:news_app/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/details/article_details_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/local_articles_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'features/daily_news/domain/usecases/delete_article.dart';

final sl = GetIt.I;
final Logger log = Logger('initdependencies');

Future<void> initdependencies() async {
  try {
    log.info('Starting dependency initialization');

    final database =
        await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    sl.registerSingleton<AppDatabase>(database);
    log.info('Registered DataBase');

    // Init DIO with base URL
    final dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!));
    sl.registerSingleton<Dio>(dio);
    log.info('Registered Dio');

    // Register NewsApiService as a singleton
    sl.registerSingleton<NewsApiService>(
      NewsApiService(sl<Dio>()),
    );
    log.info('Registered NewsApiService');

    // Concrete Article Repo
    sl.registerSingleton<ArticleRepo>(
      ArticleRepoImpl(sl<NewsApiService>(), sl<AppDatabase>()),
    );
    log.info('Registered ArticleRepo');

    // GetArticleUsecase
    sl.registerSingleton<GetArticleUsecase>(
      GetArticleUsecase(sl<ArticleRepo>()),
    );
    log.info('Registered GetArticleUsecase');
    sl.registerSingleton<GetSavedArticlesUsecase>(
      GetSavedArticlesUsecase(sl<ArticleRepo>()),
    );
    log.info('Registered GetSavedArticlesUsecase');
    sl.registerSingleton<SaveArticlesUsecase>(
      SaveArticlesUsecase(sl<ArticleRepo>()),
    );
    log.info('Registered SaveArticlesUsecase');
    sl.registerSingleton<DeleteArticleUsecase>(
      DeleteArticleUsecase(sl<ArticleRepo>()),
    );
    log.info('Registered DeleteArticleUsecase');

    // RemoteArticleBloc
    sl.registerFactory<RemoteArticleBloc>(
      () => RemoteArticleBloc(sl<GetArticleUsecase>()),
    );
    log.info('Registered RemoteArticleBloc');
    sl.registerFactory<LocalArticlesBloc>(
          () => LocalArticlesBloc(sl<GetSavedArticlesUsecase>(),sl<DeleteArticleUsecase>()),
    );
    log.info('Registered LocalArticlesBloc');
    sl.registerFactory<ArticleDetailsBloc>(
          () => ArticleDetailsBloc(sl<SaveArticlesUsecase>()),
    );
    log.info('Registered ArticleDetailsBloc');

    log.info('Completed dependency initialization');
  } catch (e, stackTrace) {
    log.severe('Error during dependency registration', e, stackTrace);
    rethrow;
  }
}
