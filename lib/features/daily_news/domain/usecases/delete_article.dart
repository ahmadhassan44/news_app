
import 'package:news_app/core/usecases/usecase.dart';
import 'package:news_app/features/daily_news/domain/repos/article_repo.dart';

import '../entities/article.dart';

class DeleteArticleUsecase extends UseCase<void,ArticleEntity> {
  final ArticleRepo _articleRepo;
  DeleteArticleUsecase(this._articleRepo);
  @override
  Future<void> call({ArticleEntity ? params}) {
    return _articleRepo.deleteArticle(params!);
  }
}