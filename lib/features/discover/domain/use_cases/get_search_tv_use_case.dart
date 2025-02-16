import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/domain/repositories/discover_repository.dart';

class GetSearchTvUseCase extends UseCase<List<MovieModel>, SearchParams> {
  final DiscoverRepository repository;

  GetSearchTvUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(
    SearchParams params,
  ) async {
    return await repository.getSearchTv(query: params.query, page: params.page);
  }
}

class SearchParams {
  final int page;
  final String query; // Flag to differentiate between Movie or TV Show

  SearchParams({required this.page, required this.query});
}
