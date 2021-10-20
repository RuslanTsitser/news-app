import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/model/article_model.dart';
import 'package:test_task/services/repository.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({
    required this.articlesRepository,
    required this.articlesRepositoryEverything,
    required this.articlesRepositoryFavorite,
    String keyWord = 'apple',
    String page = '1',
    String pageSize = '15',
  })  : _page = page,
        _pageSize = pageSize,
        _keyWord = keyWord,
        super(ArticlesEmptyState());
  final ArticlesRepository articlesRepository;
  final ArticlesRepositoryEverything articlesRepositoryEverything;
  final ArticlesRepositoryFavorite articlesRepositoryFavorite;
  final String _keyWord;
  final String _page;
  final String _pageSize;

  List<Article> loadedArticlesList = [];
  List<Article> loadedArticlesListOfEverything = [];
  Set<Article> repositoryFavoriteArticles = {};

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (event is ArticlesLoadEvent) {
      yield ArticlesLoadingState();
      try {
        final List<Article> _loadedArticleList = await articlesRepository
            .getArticles(keyWord: _keyWord, page: _page, pageSize: _pageSize);
        final List<Article> _loadedArticleListOfEverything =
            await articlesRepositoryEverything.getArticles(
                keyWord: _keyWord, page: _page, pageSize: _pageSize);
        loadedArticlesList = _loadedArticleList;
        loadedArticlesListOfEverything = _loadedArticleListOfEverything;
        yield ArticlesLoadedState(
          loadedArticles: loadedArticlesList,
          loadedArticlesEverything: loadedArticlesListOfEverything,
          favoriteArticles: repositoryFavoriteArticles,
        );
      } catch (_) {
        yield ArticlesErrorState();
      }
    }

    if (event is ArticlesCheckEverythingEvent) {
      try {
        final List<Article> _loadArticleListOfEverything =
            await articlesRepositoryEverything.getArticles(
                keyWord: _keyWord, page: _page, pageSize: _pageSize);
        if (_loadArticleListOfEverything != loadedArticlesListOfEverything) {
          loadedArticlesListOfEverything = _loadArticleListOfEverything;

          yield ArticlesLoadedState(
            loadedArticles: loadedArticlesList,
            loadedArticlesEverything: loadedArticlesListOfEverything,
            favoriteArticles: repositoryFavoriteArticles,
          );
        }
      } catch (_) {
        yield ArticlesErrorState();
      }
    }

    if (event is ArticlesCheckHeadlinesEvent) {
      try {
        final List<Article> _loadArticleList = await articlesRepository
            .getArticles(keyWord: _keyWord, page: _page, pageSize: _pageSize);

        if (_loadArticleList != loadedArticlesList) {
          loadedArticlesList = _loadArticleList;

          yield ArticlesLoadedState(
            loadedArticles: loadedArticlesList,
            loadedArticlesEverything: loadedArticlesListOfEverything,
            favoriteArticles: repositoryFavoriteArticles,
          );
        }
      } catch (_) {
        yield ArticlesErrorState();
      }
    }
    if (event is ArticlesUpdateFavoriteEvent) {
      yield* _updateFavoritesArticles(event);
    }
  }

  Stream<ArticlesState> _updateFavoritesArticles(
      ArticlesUpdateFavoriteEvent event) async* {
    if (articlesRepositoryFavorite.favorites.contains(event.article) == false) {
      articlesRepositoryFavorite.favorites.add(event.article);
      repositoryFavoriteArticles = articlesRepositoryFavorite.favorites;
    } else {
      articlesRepositoryFavorite.favorites.remove(event.article);
      repositoryFavoriteArticles = articlesRepositoryFavorite.favorites;
    }

    yield ArticlesLoadedState(
      loadedArticles: loadedArticlesList,
      loadedArticlesEverything: loadedArticlesListOfEverything,
      favoriteArticles: repositoryFavoriteArticles,
    );
  }
}
