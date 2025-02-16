import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/features/detail/data/remote/data_sources/detail_remote_data_source.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repository.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDataSource remoteDataSource;

  DetailRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, MovieDetailsModel>> getDetailsMovie({
    required int movieId,
  }) async {
    try {
      // Assuming remoteDataSource.getDetails() returns a Future<MovieDetailsModel>
      final result = await remoteDataSource.getDetailsMovie(
        movieId: movieId,
      );

      return Right(result); // Success: Return the movie or TV show details
    } catch (e) {
      return Left(ServerFailure(
          message: e.toString())); // Error: Return failure with error message
    }
  }

  @override
  Future<Either<Failure, TvShow>> getDetailsTv({required int movieId}) async {
    try {
      // Assuming remoteDataSource.getDetails() returns a Future<MovieDetailsModel>
      final result = await remoteDataSource.getDetailsTv(
        movieId: movieId,
      );

      return Right(result); // Success: Return the movie or TV show details
    } catch (e) {
      return Left(ServerFailure(
          message: e.toString())); // Error: Return failure with error message
    }
  }
}
