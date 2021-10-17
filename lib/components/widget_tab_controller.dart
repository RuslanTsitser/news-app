import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/components/widget_list_tile.dart';

class MyTabController extends StatefulWidget {
  const MyTabController({Key? key}) : super(key: key);

  @override
  _MyTabControllerState createState() => _MyTabControllerState();
}

class _MyTabControllerState extends State<MyTabController> {
  // @override
  // void initState() {
  //   BlocProvider.of<ArticlesBloc>(context).add(ArticlesLoadEvent());
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   BlocProvider.of<ArticlesBloc>(context).close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // final ArticlesBloc articleBloc = BlocProvider.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     articleBloc.add(ArticlesLoadEvent());
        //   },
        // ),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Top headlines'),
              Tab(text: 'Everything'),
            ],
          ),
          title: const Text('NewsAPI.org'),
          centerTitle: true,
        ),
        body: const MyTabBarView(),
      ),
    );
  }
}

class MyTabBarView extends StatelessWidget {
  const MyTabBarView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticlesBloc articleBloc = BlocProvider.of(context);
    Timer? timer;
    return TabBarView(
      children: [
        BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (context, state) {
            if (state is ArticlesEmptyState) {
              articleBloc.add(ArticlesLoadEvent());
              return const Center(
                  child: Text("Something I couldn't understand"));
            } else if (state is ArticlesLoadedState) {
              return ListView.builder(
                itemCount: state.loadedArticles.length,
                itemBuilder: (context, index) =>
                    customListTile(state.loadedArticles[index], context),
              );
            } else if (state is ArticlesErrorState) {
              return const Center(child: Text("Something wrong"));
            }
            timer = Timer.periodic(Duration(seconds: 5),
                (Timer t) => articleBloc.add(ArticlesCheckEvent()));
            return const Center(child: CircularProgressIndicator());
          },
        ),
        RefreshIndicator(
          onRefresh: () {
            articleBloc.add(ArticlesLoadEvent());
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
        ),
      ],
    );
  }
}
