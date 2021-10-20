import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/model/article_model.dart';
import 'package:test_task/components/widget_page_details_of_news.dart';

Widget customListTile(
    Article article, ArticlesBloc articlesBloc, BuildContext context) {
  return InkWell(
    onLongPress: () {
      articlesBloc.add(ArticlesUpdateFavoriteEvent(
        article: article,
      ));
    },
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticlePage(article: article)),
      );
    },
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 3.0)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(article.urlToImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  article.source.name ?? 'Unknown',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              articlesBloc.repositoryFavoriteArticles.contains(article)
                  ? const Icon(Icons.star)
                  : const Icon(Icons.star_border),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            article.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    ),
  );
}
