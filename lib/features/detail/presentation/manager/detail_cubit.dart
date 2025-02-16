import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/detail/domain/use_cases/get_details_tv_use_case.dart';
import 'package:movie_app/features/detail/domain/use_cases/get_details_use_case.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailCubit extends Cubit<DetailState> {
  final GetDetailsMoviesUseCase getDetailsMoviesUseCase;
  final GetDetailsTvsUseCase getDetailsTvsUseCase;
  DetailCubit({
    required this.getDetailsMoviesUseCase,
    required this.getDetailsTvsUseCase,
  }) : super(DetailInitial());
  final String ratingKey = "movie_rating"; // Key to store ratings
  Future<void> fetchMovieDetails(
    int movieId,
  ) async {
    emit(DetailLoading());
    try {
      final result = await getDetailsMoviesUseCase(movieId);
      double rating = await getRating(movieId);
      result.fold(
        (failure) => emit(DetailError(failure.message)),
        (movieDetails) =>
            emit(DetailMovieDetailsLoaded(movieDetails, rating: rating)),
      );
    } catch (e) {
      emit(DetailError("Failed to load movie details"));
    }
  }

  Future<void> fetchTvDetails(
    int movieId,
  ) async {
    emit(DetailLoading());
    try {
      final result = await getDetailsTvsUseCase(movieId);

      result.fold(
        (failure) => emit(DetailError(failure.message)),
        (movieDetails) => emit(DetailTvDetailsLoaded(
          movieDetails,
        )),
      );
    } catch (e) {
      emit(DetailError("Failed to load movie details"));
    }
  }

  Future<double> getRating(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("$ratingKey$movieId") ?? 0.0; // Default 0
  }

  Future<void> setRating(int movieId, double rating) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("$ratingKey$movieId", rating);
    emit(DetailMovieDetailsLoaded((state as DetailMovieDetailsLoaded).tvShows,
        rating: rating));
  }
}
