
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

import '../entities/article.dart';

class SaveArticlesUsecase extends UseCase<void,ArticleEntity> {
  final ArticleRepo _articleRepo;
  SaveArticlesUsecase(this._articleRepo);
  @override
  Future<void> call({ArticleEntity ? params}) {
    return _articleRepo.saveArticle(params!);
  }

}