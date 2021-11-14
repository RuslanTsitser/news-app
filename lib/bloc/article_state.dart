import 'package:equatable/equatable.dart';

abstract class ArticlesState extends Equatable {}

class ArticlesLoadingState extends ArticlesState {
  @override
  List<Object?> get props => [];
}

class ArticlesEmptyState extends ArticlesState {
  @override
  List<Object?> get props => [];
}

class ArticlesLoadedState extends ArticlesState {
  List<dynamic> loadedArticles;
  List<dynamic> loadedArticlesEverything;
  Set<dynamic> favoriteArticles;

  ArticlesLoadedState({
    required this.loadedArticles,
    required this.loadedArticlesEverything,
    required this.favoriteArticles,
  });

  @override
  List<Object?> get props =>
      [loadedArticles, loadedArticlesEverything, favoriteArticles];
}

class ArticlesErrorState extends ArticlesState {
  @override
  List<Object?> get props => [];
}
