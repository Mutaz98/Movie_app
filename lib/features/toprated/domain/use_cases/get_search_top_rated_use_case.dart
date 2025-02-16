import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/toprated/domain/repositories/top_reated_repository.dart';

class GetSearchMoviesTopRatedUseCase
    extends UseCase<List<MovieModel>, GetMovieTopRatedSearch> {
  final TopRatedRepository repository;

  GetSearchMoviesTopRatedUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(
    GetMovieTopRatedSearch params,
  ) async {
    return await repository.searchMovieTopRated(
        query: params.query, page: params.page);
  }
}

class GetMovieTopRatedSearch {
  final int page;
  final String query; // Flag to differentiate between Movie or TV Show

  GetMovieTopRatedSearch({required this.page, required this.query});
}
