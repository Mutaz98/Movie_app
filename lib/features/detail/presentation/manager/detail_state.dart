import 'package:equatable/equatable.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';

import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

// Define the states
abstract class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailMovieDetailsLoaded extends DetailState {
  final MovieDetailsModel tvShows;
  final double rating; // Add rating field

  DetailMovieDetailsLoaded(this.tvShows, {this.rating = 0.0});

  @override
  List<Object?> get props => [tvShows, rating];

  DetailMovieDetailsLoaded copyWith({double? rating}) {
    return DetailMovieDetailsLoaded(tvShows, rating: rating ?? this.rating);
  }
}

class DetailTvDetailsLoaded extends DetailState {
  final TvShow tvShows;

  DetailTvDetailsLoaded(
    this.tvShows,
  );

  @override
  List<Object?> get props => [
        tvShows,
      ];
}

class DetailError extends DetailState {
  final String message;

  DetailError(this.message);

  @override
  List<Object?> get props => [message];
}
