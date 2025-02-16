// movie_favorite_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favourite/data/local/fav_local_data_source.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:movie_app/features/favourite/presentation/manager/event.dart';
import 'package:movie_app/features/favourite/presentation/manager/state.dart';

class MovieFavoriteBloc extends Bloc<MovieFavoriteEvent, MovieFavoriteState> {
  final FavoritesLocalDataSource localDataSource;
  final Set<int> _favoriteIds = {}; // Track favorite IDs in memory

  MovieFavoriteBloc({required this.localDataSource})
      : super(MovieFavoriteInitial()) {
    on<AddToFavoritesEvent>(_onAddToFavoritesEvent);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavoritesEvent);
    on<CheckIfFavoriteEvent>(_onCheckIfFavoriteEvent);
    on<GetFavoritesEvent>(_onGetFavoritesEvent);

    // Initialize with existing favorites
    add(GetFavoritesEvent());
  }

  Future<void> _onAddToFavoritesEvent(
      AddToFavoritesEvent event, Emitter<MovieFavoriteState> emit) async {
    try {
      await localDataSource.addMovieToFavorites(event.movie);
      _favoriteIds.add(event.movie.id);
      final List<MovieModelLocal> updatedFavorites =
          await localDataSource.getFavorites();

      emit(MovieFavoriteListLoaded(updatedFavorites));
    } catch (e) {
      emit(MovieFavoriteError(e.toString()));
    }
  }

  Future<void> _onRemoveFromFavoritesEvent(
      RemoveFromFavoritesEvent event, Emitter<MovieFavoriteState> emit) async {
    try {
      await localDataSource.removeMovieFromFavorites(event.movieId);
      _favoriteIds.remove(event.movieId);
      final List<MovieModelLocal> updatedFavorites =
          await localDataSource.getFavorites();

      emit(MovieFavoriteListLoaded(updatedFavorites));
    } catch (e) {
      emit(MovieFavoriteError(e.toString()));
    }
  }

  Future<void> _onCheckIfFavoriteEvent(
      CheckIfFavoriteEvent event, Emitter<MovieFavoriteState> emit) async {
    try {
      // Check both memory cache and local data source
      final isCached = _favoriteIds.contains(event.movieId);
      if (!isCached) {
        final isPersisted = await localDataSource.isFavorite(event.movieId);
        emit(MovieFavoriteCheckSuccess(event.movieId, isPersisted));
      } else {
        emit(MovieFavoriteCheckSuccess(event.movieId, true));
      }
    } catch (e) {
      emit(MovieFavoriteError(e.toString()));
    }
  }

  Future<void> _onGetFavoritesEvent(
      GetFavoritesEvent event, Emitter<MovieFavoriteState> emit) async {
    try {
      emit(MovieFavoriteLoading());
      final favorites = await localDataSource.getFavorites();
      _favoriteIds.addAll(favorites.map((m) => m.id));
      emit(MovieFavoriteListLoaded(favorites));
    } catch (e) {
      emit(MovieFavoriteError(e.toString()));
    }
  }
}
