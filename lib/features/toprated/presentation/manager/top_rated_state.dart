import 'package:equatable/equatable.dart';

import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

// Define the states
abstract class TopRatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopRatedInitial extends TopRatedState {}

class TopRatedLoading extends TopRatedState {}

class TopRatedMoviesLoaded extends TopRatedState {
  final List<MovieModel> movies;
  final bool hasReachedMax;

  TopRatedMoviesLoaded({
    required this.movies,
    required this.hasReachedMax,
  });

  TopRatedMoviesLoaded copyWith({
    List<MovieModel>? movies,
    bool? hasReachedMax,
  }) {
    return TopRatedMoviesLoaded(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class TopRatedError extends TopRatedState {
  final String message;

  TopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}
