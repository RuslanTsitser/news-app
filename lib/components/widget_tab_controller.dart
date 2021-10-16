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
  @override
  Widget build(BuildContext context) {
    final ArticlesBloc articleBloc = BlocProvider.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            articleBloc.add(ArticlesLoadEvent());
          },
        ),
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
    return TabBarView(
      children: [
        BlocBuilder<ArticlesBloc, ArticlesState>(
          builder: (context, state) {
            if (state is ArticlesLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ArticlesLoadedState) {
              return ListView.builder(
                itemCount: state.loadedArticles.length,
                itemBuilder: (context, index) =>
                    customListTile(state.loadedArticles[index], context),
              );
            }
            return const Center(child: Text('Press the button'));
          },
        ),
        RefreshIndicator(
          onRefresh: () {
            articleBloc.add(ArticlesLoadEvent());
            return Future.delayed(Duration(seconds: 1), () {});
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
              return const Center(child: Text('Press the button'));
            },
          ),
        ),
      ],
    );
  }
}
