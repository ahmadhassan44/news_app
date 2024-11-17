
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

import '../../../../core/resources/data_state.dart';
import '../entities/article.dart';

class GetSavedArticlesUsecase extends UseCase<List<ArticleEntity>,void> {
  final ArticleRepo _articleRepo;
  GetSavedArticlesUsecase(this._articleRepo);
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepo.getSavedArticles();
  }

}