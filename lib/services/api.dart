import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:test_task/model/article_model.dart';

class ApiService {
  final endPointUrl = 'newsapi.org';
  final client = http.Client();

  final String endPointTopic;
  ApiService({required this.endPointTopic});
  Future<List<Article>> getArticle({
    required String keyWord,
    required String page,
    required String pageSize,
  }) async {
    final queryParameters = {
      'q': keyWord,
      'page': page,
      'pageSize': pageSize,
      'apiKey': '5bddeeff55ad43eaa43023bfe7576954'
    };
    final uri = Uri.https(endPointUrl, endPointTopic, queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
