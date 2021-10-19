import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/components/widget_tab_everything.dart';
import 'package:test_task/components/widget_tab_headlines.dart';

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
        body: TabBarView(
          children: [
            TabHeadlines(articleBloc: articleBloc),
            TabEverything(articleBloc: articleBloc),
          ],
        ),
      ),
    );
  }
}
