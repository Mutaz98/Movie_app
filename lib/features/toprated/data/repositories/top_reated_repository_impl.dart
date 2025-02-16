import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/utils/helpers.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/toprated/data/remote/data_sources/top_rated_remote_data_source.dart';
import 'package:movie_app/features/toprated/domain/repositories/top_reated_repository.dart';

class TopRatedRepositoryImpl implements TopRatedRepository {
  final TopRatedRemoteDataSource remoteDataSource;

  TopRatedRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<MovieModel>>> getTopRatedMovies(
      {required int page}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.getTopRatedMovies(page: page),
    );
  }

  @override
  Future<Either<Failure, List<MovieModel>>> searchMovieTopRated(
      {required int page, required String query}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.searchMovieTopRated(page: page, query: query),
    );
  }
}
