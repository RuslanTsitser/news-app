import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:test_task/model/article_model.dart';

class ApiService {
  final endPointUrl = 'newsapi.org';
  final client = http.Client();
  final String keyWord;
  final String endPointTopic;
  ApiService({required this.keyWord, required this.endPointTopic});
  Future<List<Article>> getArticle() async {
    final queryParameters = {
      'q': keyWord,
      'apiKey': '15696e7f09e340248d3318dbccca9764'
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
