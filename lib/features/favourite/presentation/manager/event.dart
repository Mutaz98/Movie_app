// movie_favorite_event.dart
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';

abstract class MovieFavoriteEvent {}

class AddToFavoritesEvent extends MovieFavoriteEvent {
  final MovieModelLocal movie;

  AddToFavoritesEvent(this.movie);
}

class RemoveFromFavoritesEvent extends MovieFavoriteEvent {
  final int movieId;

  RemoveFromFavoritesEvent(this.movieId);
}

class CheckIfFavoriteEvent extends MovieFavoriteEvent {
  final int movieId;

  CheckIfFavoriteEvent(this.movieId);
}

class GetFavoritesEvent extends MovieFavoriteEvent {}
