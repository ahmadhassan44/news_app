import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';


final Logger log=Logger("repo_impl");
class ArticleRepoImpl implements ArticleRepo{
  final NewsApiService _apiService;
  ArticleRepoImpl(this._apiService);
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async{
    try{
      final httpResponse=await _apiService.getNewsArticles(
          apiKey: dotenv.env["API_KEY"],
          country: "us",
          category: "sports"
      );
      if(httpResponse.response.statusCode==HttpStatus.ok){
        log.info("Successfully got articles");
        log.info("Response: ${httpResponse.response}");
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

}