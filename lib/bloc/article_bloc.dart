import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/bloc/article_event.dart';
import 'package:test_task/bloc/article_state.dart';
import 'package:test_task/model/article_model.dart';
import 'package:test_task/services/repository.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  ArticlesBloc({
    required this.articlesRepository,
    required this.articlesRepositoryEverything,
    String keyWord = 'apple',
    String page = '1',
    String pageSize = '15',
  })  : _page = page,
        _pageSize = pageSize,
        _keyWord = keyWord,
        super(ArticlesEmptyState());
  final ArticlesRepository articlesRepository;
  final ArticlesRepositoryEverything articlesRepositoryEverything;
  final String _keyWord;
  final String _page;
  final String _pageSize;

  @override
  Stream<ArticlesState> mapEventToState(ArticlesEvent event) async* {
    if (event is ArticlesLoadEvent) {
      yield ArticlesLoadingState();
      try {
        final List<Article> _loadArticleList = await articlesRepository
            .getArticles(keyWord: _keyWord, page: _page, pageSize: _pageSize);
        final List<Article> _loadArticleListOfEverything =
            await articlesRepositoryEverything.getArticles(
                keyWord: _keyWord, page: _page, pageSize: _pageSize);
        yield ArticlesLoadedState(
          loadedArticles: _loadArticleList,
          loadedArticlesEverything: _loadArticleListOfEverything,
        );
      } catch (_) {
        yield ArticlesErrorState();
      }
    }
  }
}
