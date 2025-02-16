import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/utils/helpers.dart';
import 'package:movie_app/features/discover/data/remote/data_sources/discover_remote_data_source.dart';

import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/domain/repositories/discover_repository.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  final DiscoverRemoteDataSource remoteDataSource;

  DiscoverRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, List<MovieModel>>> getDiscoverMovies(
      {required int page}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.getDiscoverMovies(page: page),
    );
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getSearchMovie(
      {required int page, required String query}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.getSearchMovie(page: page, query: query),
    );
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getSearchTv(
      {required int page, required String query}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.getSearchTv(page: page, query: query),
    );
  }

  @override
  Future<Either<Failure, List<MovieModel>>> getDiscoverTvShows(
      {required int page}) async {
    return getRepositoryResponse<List<MovieModel>, List<MovieModel>>(
      remoteDataSource.getDiscoverTvShows(page: page),
    );
  }
}
