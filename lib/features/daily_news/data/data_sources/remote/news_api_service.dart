import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/article.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class NewsApiService {
  factory NewsApiService(Dio dio) =_NewsApiService;

  @GET("/top-headlines")
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}