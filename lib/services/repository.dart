import 'package:test_task/model/article_model.dart';
import 'package:test_task/services/api.dart';

class ArticlesRepository {
  final ApiService _articlesProvider =
      ApiService(endPointTopic: '/v2/top-headlines');
  Future<List<Article>> getArticles({
    required String keyWord,
    required String page,
    required String pageSize,
  }) =>
      _articlesProvider.getArticle(
          keyWord: keyWord, page: page, pageSize: pageSize);
}

class ArticlesRepositoryEverything {
  final ApiService _articlesProvider =
      ApiService(endPointTopic: '/v2/everything');
  Future<List<Article>> getArticles({
    required String keyWord,
    required String page,
    required String pageSize,
  }) =>
      _articlesProvider.getArticle(
          keyWord: keyWord, page: page, pageSize: pageSize);
}

class ArticlesRepositoryFavorite {
  Set<Article> favorites = {};
}
