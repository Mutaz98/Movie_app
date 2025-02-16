import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/favourite/data/local/fav_local_data_source.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:movie_app/features/favourite/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToFavorites(MovieModelLocal movie) {
    return localDataSource.addMovieToFavorites(movie);
  }

  @override
  Future<void> removeFromFavorites(int movieId) {
    return localDataSource.removeMovieFromFavorites(movieId);
  }

  @override
  Future<bool> isFavorite(int movieId) {
    return localDataSource.isFavorite(movieId);
  }

  @override
  Future<List<MovieModelLocal>> getFavorites() {
    return localDataSource.getFavorites();
  }
}
