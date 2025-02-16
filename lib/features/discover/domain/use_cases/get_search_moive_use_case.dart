import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/domain/repositories/discover_repository.dart';

class GetSearchMoviesUseCase extends UseCase<List<MovieModel>, GetMovieSearch> {
  final DiscoverRepository repository;

  GetSearchMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(
    GetMovieSearch params,
  ) async {
    return await repository.getSearchMovie(
        query: params.query, page: params.page);
  }
}

class GetMovieSearch {
  final int page;
  final String query; // Flag to differentiate between Movie or TV Show

  GetMovieSearch({required this.page, required this.query});
}
