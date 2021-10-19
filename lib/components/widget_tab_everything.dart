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
        articleBloc.add(ArticlesCheckEvent());
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
              itemBuilder: (context, index) => customListTile(
                  state.loadedArticlesEverything[index], context),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
