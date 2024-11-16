import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:news_app/features/daily_news/data/repos_impl/article_repo_impl.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';
import 'package:news_app/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'features/daily_news/data/data_sources/remote/news_api_service.dart';

final sl = GetIt.I;
final Logger log = Logger('initdependencies');

Future<void> initdependencies() async {
  try {
    log.info('Starting dependency initialization');

    // final database=await $FloorAppDatabase.databaseBuilder("app_database.db").build();
    // sl.registerSingleton<AppDatabase>(database);
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
      ArticleRepoImpl(sl<NewsApiService>()),
    );
    log.info('Registered ArticleRepo');

    // GetArticleUsecase
    sl.registerSingleton<GetArticleUsecase>(
      GetArticleUsecase(sl<ArticleRepo>()),
    );
    log.info('Registered GetArticleUsecase');

    // RemoteArticleBloc
    sl.registerFactory<RemoteArticleBloc>(
          () => RemoteArticleBloc(sl<GetArticleUsecase>()),
    );
    log.info('Registered RemoteArticleBloc');

    log.info('Completed dependency initialization');
  } catch (e, stackTrace) {
    log.severe('Error during dependency registration', e, stackTrace);
    rethrow;
  }
}