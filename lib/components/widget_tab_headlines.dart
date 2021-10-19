import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/components/widget_list_tile.dart';

class TabHeadlines extends StatelessWidget {
  const TabHeadlines({
    Key? key,
    required this.articleBloc,
  }) : super(key: key);

  final ArticlesBloc articleBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticlesBloc, ArticlesState>(
      builder: (context, state) {
        if (state is ArticlesEmptyState) {
          articleBloc.add(ArticlesLoadEvent());
          return const Center(child: Text("Something I couldn't understand"));
        } else if (state is ArticlesLoadedState) {
          return ListView.builder(
            itemCount: state.loadedArticles.length,
            itemBuilder: (context, index) =>
                customListTile(state.loadedArticles[index], context),
          );
        } else if (state is ArticlesErrorState) {
          return const Center(child: Text("Something wrong"));
        }
        Timer.periodic(const Duration(seconds: 5),
            (Timer t) => articleBloc.add(ArticlesCheckEvent()));
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
