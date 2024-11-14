import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app/features/daily_news/data/models/article.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

class ArticleRepoImpl implements ArticleRepo{
  final NewsApiService _apiService;
  ArticleRepoImpl(this._apiService);
  @override
  Future<DataState<List<ArticleModel>>> getArticles() async{
    final httpResponse=await _apiService.getNewsArticles(
      apiKey: dotenv.env["NEWS_API_KEY"],
      country: "us",
      category: "general"
    );
  }

}