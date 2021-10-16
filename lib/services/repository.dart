import 'package:test_task/model/article_model.dart';
import 'package:test_task/services/api.dart';

class ArticlesRepository {
  final ApiService _articlesProvider =
      ApiService(endPointTopic: '/v2/top-headlines', keyWord: 'apple');
  Future<List<Article>> getArticles() => _articlesProvider.getArticle();
}

class ArticlesRepositoryEverything {
  final ApiService _articlesProvider =
      ApiService(endPointTopic: '/v2/everything', keyWord: 'apple');
  Future<List<Article>> getArticles() => _articlesProvider.getArticle();
}
