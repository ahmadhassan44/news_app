import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

class GetArticleUsecase implements UseCase<DataState<List<ArticleEntity>>,void>{
  final ArticleRepo _articleRepo;
  GetArticleUsecase(this._articleRepo);
  @override
  Future<DataState<List<ArticleEntity>>> call({params}) {
    return _articleRepo.getArticles();
  }

}