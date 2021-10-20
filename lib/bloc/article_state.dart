abstract class ArticlesState {}

class ArticlesLoadingState extends ArticlesState {}

class ArticlesEmptyState extends ArticlesState {}

class ArticlesLoadedState extends ArticlesState {
  List<dynamic> loadedArticles;
  List<dynamic> loadedArticlesEverything;
  Set<dynamic> favoriteArticles;

  ArticlesLoadedState({
    required this.loadedArticles,
    required this.loadedArticlesEverything,
    required this.favoriteArticles,
  });
}

class ArticlesErrorState extends ArticlesState {}
