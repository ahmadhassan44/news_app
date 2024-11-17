import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/database/news_app_database.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';


final Logger log=Logger("repo_impl");
class ArticleRepoImpl implements ArticleRepo{
  final NewsApiService _apiService;
  final AppDatabase _appDatabase;
  ArticleRepoImpl(this._apiService,this._appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async{
    try{
      final httpResponse=await _apiService.getNewsArticles(
          apiKey: dotenv.env["API_KEY"],
          country: "us",
          category: "sports"
      );
      if(httpResponse.response.statusCode==HttpStatus.ok){
        // log.info("Successfully got articles");
        // log.info("Response: ${httpResponse.response}");
        return DataSuccess(httpResponse.data);
      } else{
        log.shout("Failed to get articles: ${httpResponse.response.statusMessage}");
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.response,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch(err){
      return DataFailed(err);
    }

  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }


  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() {
    return _appDatabase.articleDao.getArticles();
  }

}