import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/domain/repositories/discover_repository.dart';

class GetDiscoverTvShowsUseCase extends UseCase<List<MovieModel>, int> {
  final DiscoverRepository repository;

  GetDiscoverTvShowsUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(int page) async {
    return await repository.getDiscoverTvShows(page: page);
  }
}
