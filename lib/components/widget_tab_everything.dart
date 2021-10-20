import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/components/widget_list_tile.dart';

class TabEverything extends StatelessWidget {
  const TabEverything({
    Key? key,
    required this.articleBloc,
  }) : super(key: key);

  final ArticlesBloc articleBloc;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        articleBloc.add(ArticlesCheckEverythingEvent());
        return Future.delayed(const Duration(seconds: 1), () {});
      },
      child: BlocBuilder<ArticlesBloc, ArticlesState>(
        builder: (context, state) {
          if (state is ArticlesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ArticlesLoadedState) {
            return ListView.builder(
              itemCount: state.loadedArticlesEverything.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: customListTile(state.loadedArticlesEverything[index],
                      articleBloc, context),
                  onLongPress: () {
                    articleBloc.add(
                      ArticlesUpdateFavoriteEvent(
                        article: state.loadedArticlesEverything[index],
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
