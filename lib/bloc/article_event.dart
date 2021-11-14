import 'package:equatable/equatable.dart';

abstract class ArticlesEvent extends Equatable {}

class ArticlesLoadEvent extends ArticlesEvent {
  @override
  List<Object?> get props => [];
}

class ArticlesCheckEverythingEvent extends ArticlesEvent {
  @override
  List<Object?> get props => [];
}

class ArticlesCheckHeadlinesEvent extends ArticlesEvent {
  @override
  List<Object?> get props => [];
}

class ArticlesUpdateFavoriteEvent extends ArticlesEvent {
  final dynamic article;

  ArticlesUpdateFavoriteEvent({
    required this.article,
  });

  @override
  List<Object?> get props => [article];
}
