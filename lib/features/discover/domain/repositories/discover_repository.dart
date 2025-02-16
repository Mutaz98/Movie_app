import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';

import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

abstract class DiscoverRepository {
  Future<Either<Failure, List<MovieModel>>> getDiscoverMovies(
      {required int page});
  Future<Either<Failure, List<MovieModel>>> getSearchMovie(
      {required int page, required String query});
  Future<Either<Failure, List<MovieModel>>> getSearchTv(
      {required int page, required String query});
  Future<Either<Failure, List<MovieModel>>> getDiscoverTvShows(
      {required int page});
}
