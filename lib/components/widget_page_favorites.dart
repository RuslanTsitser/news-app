import 'package:flutter/material.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/components/widget_list_tile.dart';
import 'package:test_task/model/article_model.dart';

class FavoritesPage extends StatelessWidget {
  final Set<Article> favoriteArticles;
  final ArticlesBloc articlesBloc;
  const FavoritesPage(
      {Key? key, required this.favoriteArticles, required this.articlesBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Favorites'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: favoriteArticles.length,
          itemBuilder: (context, index) {
            return customListTile(
                favoriteArticles.elementAt(index), articlesBloc, context);
          },
        ),
      ),
    );
  }
}
