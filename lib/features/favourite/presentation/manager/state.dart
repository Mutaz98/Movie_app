import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';

abstract class MovieFavoriteState {}

class MovieFavoriteInitial extends MovieFavoriteState {}

class MovieFavoriteLoading extends MovieFavoriteState {}

class MovieFavoriteAdded extends MovieFavoriteState {}

class MovieFavoriteRemoved extends MovieFavoriteState {}

class MovieFavoriteCheckSuccess extends MovieFavoriteState {
  final int movieId;
  final bool isFavorite;

  MovieFavoriteCheckSuccess(this.movieId, this.isFavorite);
}

class MovieFavoriteError extends MovieFavoriteState {
  final String errorMessage;

  MovieFavoriteError(this.errorMessage);
}

class MovieFavoriteListLoaded extends MovieFavoriteState {
  final List<MovieModelLocal> favorites;

  MovieFavoriteListLoaded(this.favorites);
}

class MovieFavoriteLoaded extends MovieFavoriteState {
  final Map<int, bool> favorites; // Map<movieId, isFavorite>

  MovieFavoriteLoaded(this.favorites);
}
