import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:movie_app/features/favourite/domain/use_cases/get_fav.dart';

abstract class FavoritesRepository {
  Future<void> addToFavorites(MovieModelLocal movie);
  Future<void> removeFromFavorites(int movieId);
  Future<bool> isFavorite(int movieId);
  Future<List<MovieModelLocal>> getFavorites();
}
