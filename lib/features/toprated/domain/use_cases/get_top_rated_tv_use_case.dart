import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/toprated/domain/repositories/top_reated_repository.dart';

class GetDiscoverTopRatedUseCase extends UseCase<List<MovieModel>, int> {
  final TopRatedRepository repository;

  GetDiscoverTopRatedUseCase(this.repository);

  @override
  Future<Either<Failure, List<MovieModel>>> call(int params) async {
    return await repository.getTopRatedMovies(page: params);
  }
}
