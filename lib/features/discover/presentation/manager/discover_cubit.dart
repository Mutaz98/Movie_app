import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_discover_movies_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_discover_tv_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_search_moive_use_case.dart';
import 'package:movie_app/features/discover/domain/use_cases/get_search_tv_use_case.dart';
import 'package:movie_app/features/discover/presentation/manager/discover_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final GetDiscoverMoviesUseCase getDiscoverMoviesUseCase;
  final GetDiscoverTvShowsUseCase getDiscoverTvShowsUseCase;

  final GetSearchMoviesUseCase getSearchMoviesUseCase;
  final GetSearchTvUseCase getSearchTvUseCase;
  DiscoverCubit({
    required this.getDiscoverMoviesUseCase,
    required this.getDiscoverTvShowsUseCase,
    required this.getSearchMoviesUseCase,
    required this.getSearchTvUseCase,
  }) : super(DiscoverInitial());

  // Fetch discoverable movies with pagination
  // int currentPage = 1;
  // bool isFetching = false;
  int currentPage = 1;
  bool isFetching = false;
  String currentQuery = '';

  Future<void> fetchData(
      int type, int page, PagingController<int, MovieModel> controller,
      [String query = '']) async {
    if (isFetching) return; // Prevent duplicate requests
    isFetching = true;

    final result = (query.isEmpty)
        ? (type == 1
            ? await getDiscoverMoviesUseCase(page) // Fetch Discover Movies
            : await getDiscoverTvShowsUseCase(page)) // Fetch Discover TV Shows
        : type == 1
            ? await getSearchMoviesUseCase(
                GetMovieSearch(page: page, query: query))
            : await getSearchTvUseCase(SearchParams(page: page, query: query));
    // Fetch Search Results

    result.fold(
      (failure) {
        controller.error = failure.message;
      },
      (data) {
        final isLastPage = data.length < 20; // Adjust based on API response
        if (isLastPage) {
          controller.appendLastPage(data);
        } else {
          controller.appendPage(data, page + 1);
        }
      },
    );

    isFetching = false;
  }

  void refreshData(
      int type, PagingController<int, MovieModel> controller, String query) {
    currentQuery = query;
    currentPage = 1;
    controller.refresh();
    fetchData(type, currentPage, controller, query);
  }

  Future<void> setRating(int movieId, double rating) async {
    final prefs = await SharedPreferences.getInstance();

    // Load existing ratings map or create an empty map if none exist
    Map<int, double> ratingsMap = {};
    final savedRatings = prefs.getString('ratings_map');

    if (savedRatings != null) {
      final Map<String, dynamic> savedRatingsMap = json.decode(savedRatings);
      ratingsMap = savedRatingsMap
          .map((key, value) => MapEntry(int.parse(key), value.toDouble()));
    }

    // Save the updated rating for the specific movie
    ratingsMap[movieId] = rating;
    // Save the updated ratings map back to SharedPreferences
    // Convert the map with int keys back to a map with string keys for JSON encoding
    Map<String, dynamic> encodedRatingsMap =
        ratingsMap.map((key, value) => MapEntry(key.toString(), value));

    await prefs.setString('ratings_map', json.encode(encodedRatingsMap));

    // Emit the MovieRatingLoaded state with the updated ratings map
    emit(MovieRatingLoaded(movieId, rating, ratingsMap));
  }

  // Get rating for a movie
  Future<double?> getRating(int movieId) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the saved ratings map from SharedPreferences
    final savedRatings = prefs.getString('ratings_map');

    if (savedRatings != null) {
      // Decode the saved ratings map from JSON (keys are Strings, values are doubles)
      final Map<String, dynamic> savedRatingsMap = json.decode(savedRatings);

      // Check if the movieId exists in the map, and return the rating
      if (savedRatingsMap.containsKey(movieId.toString())) {
        return savedRatingsMap[movieId.toString()].toDouble();
      }
      emit(DiscoverRatingSet(savedRatingsMap[movieId.toString()].toDouble()));
    }

    // If no rating found, return null
    return null;
  }

  // Delete rating for a movie
  Future<void> deleteRating(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('movie_$movieId'); // Remove the rating
    emit(MovieRatingDeleted(movieId)); // Emit the rating deletion (optional)
  }
}
