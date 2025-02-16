import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

abstract class TopRatedRepository {
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies(
      {required int page});
  Future<Either<Failure, List<MovieModel>>> searchMovieTopRated(
      {required int page, required String query});
}
