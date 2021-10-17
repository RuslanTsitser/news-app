import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/model/article_model.dart';
import 'package:test_task/services/repository.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({
    required this.articlesRepository,
    required this.articlesRepositoryEverything,
  }) : super(ArticlesEmptyState()) {
    add(ArticlesLoadEvent());
  }
  final ArticlesRepository articlesRepository;
  final ArticlesRepositoryEverything articlesRepositoryEverything;

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    ArticlesLoadedState articlesLoadedState =
        ArticlesLoadedState(loadedArticles: [], loadedArticlesEverything: []);
    if (event is ArticlesLoadEvent) {
      yield ArticlesLoadingState();
      try {
        final List<Article> _loadArticleList =
            await articlesRepository.getArticles();
        final List<Article> _loadArticleListOfEverything =
            await articlesRepositoryEverything.getArticles();
        articlesLoadedState = ArticlesLoadedState(
          loadedArticles: _loadArticleList,
          loadedArticlesEverything: _loadArticleListOfEverything,
        );
        yield articlesLoadedState;
      } catch (_) {
        yield ArticlesErrorState();
      }
    }
    if (event is ArticlesCheckEvent) {
      try {
        final List<Article> _loadArticleList =
            await articlesRepository.getArticles();
        final List<Article> _loadArticleListOfEverything =
            await articlesRepositoryEverything.getArticles();
        if (_loadArticleList != articlesLoadedState.loadedArticles) {
          articlesLoadedState = ArticlesLoadedState(
            loadedArticles: _loadArticleList,
            loadedArticlesEverything: _loadArticleListOfEverything,
          );
          yield articlesLoadedState;
        }
      } catch (_) {
        yield ArticlesErrorState();
      }
    }
  }
}
