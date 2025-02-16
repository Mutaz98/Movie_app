import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repository.dart';

class GetDetailsMoviesUseCase extends UseCase<MovieDetailsModel, int> {
  final DetailRepository repository;

  GetDetailsMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MovieDetailsModel>> call(int params) async {
    return await repository.getDetailsMovie(
      movieId: params,
    );
  }
}

// class GetDetailsParams {
//   final int movieId;
//   final bool isMovie; // Flag to differentiate between Movie or TV Show

//   GetDetailsParams({required this.movieId, required this.isMovie});
// }
