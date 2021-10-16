abstract class ArticlesState {}

class ArticlesLoadingState extends ArticlesState {}

class ArticlesEmptyState extends ArticlesState {}

class ArticlesLoadedState extends ArticlesState {
  List<dynamic> loadedArticles;
  List<dynamic> loadedArticlesEverything;

  ArticlesLoadedState(
      {required this.loadedArticles, required this.loadedArticlesEverything});
}

class ArticlesErrorState extends ArticlesState {}
