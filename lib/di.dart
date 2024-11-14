import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/repos_impl/article_repo_impl.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'features/daily_news/domain/usecases/get_article.dart';

final sl = GetIt.instance;

initdependencies() async {
  // Init DIO
  sl.registerSingleton<Dio>(Dio());

  // API Service
  sl.registerSingleton<NewsApiService>(NewsApiService(sl<Dio>()));

  // Concrete Article Repo
  sl.registerSingleton<ArticleRepo>(ArticleRepoImpl(sl<NewsApiService>()));

  // GetArticleUsecase
  sl.registerSingleton<GetArticleUsecase>(GetArticleUsecase(sl<ArticleRepo>()));

  // RemoteArticleBloc
  sl.registerFactory<RemoteArticleBloc>(
        () => RemoteArticleBloc(sl<GetArticleUsecase>()),
  );
}
