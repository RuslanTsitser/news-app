abstract class ArticlesEvent {}

class ArticlesLoadEvent extends ArticlesEvent {}

class ArticlesCheckEverythingEvent extends ArticlesEvent {}

class ArticlesCheckHeadlinesEvent extends ArticlesEvent {}

class ArticlesUpdateFavoriteEvent extends ArticlesEvent {
  final dynamic article;

  ArticlesUpdateFavoriteEvent({
    required this.article,
  });
}
