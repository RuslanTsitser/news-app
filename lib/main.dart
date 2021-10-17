import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/services/repository.dart';

import 'components/widget_tab_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final articlesRepository = ArticlesRepository();
    final articlesRepositoryEverything = ArticlesRepositoryEverything();
    return BlocProvider<ArticlesBloc>(
      create: (context) => ArticlesBloc(
        articlesRepository: articlesRepository,
        articlesRepositoryEverything: articlesRepositoryEverything,
      ),
      child: const MyTabController(),
    );
  }
}
