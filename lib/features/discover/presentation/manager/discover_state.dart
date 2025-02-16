import 'package:equatable/equatable.dart';

import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

// Define the states
abstract class DiscoverState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class DiscoverMoviesLoaded extends DiscoverState {
  final List<MovieModel> movies;
  final bool hasReachedMax;

  DiscoverMoviesLoaded({
    required this.movies,
    required this.hasReachedMax,
  });

  DiscoverMoviesLoaded copyWith({
    List<MovieModel>? movies,
    bool? hasReachedMax,
  }) {
    return DiscoverMoviesLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class DiscoverTvShowsLoaded extends DiscoverState {
  final List<MovieModel> tvShows;

  DiscoverTvShowsLoaded(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

class DiscoverError extends DiscoverState {
  final String message;

  DiscoverError(this.message);

  @override
  List<Object?> get props => [message];
}

class DiscoverRatingSet extends DiscoverState {
  final double rating;
  DiscoverRatingSet(this.rating);
}

class MovieRatingLoaded extends DiscoverState {
  final int movieId;
  final double rating;
  final Map<int, double> ratings; // Add a map of all movie ratings

  MovieRatingLoaded(this.movieId, this.rating, this.ratings);
}

class MovieRatingDeleted extends DiscoverState {
  final int movieId;
  MovieRatingDeleted(this.movieId);
}
