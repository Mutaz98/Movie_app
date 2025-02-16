import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/core/use_cases/use_case.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';
import 'package:movie_app/features/detail/domain/repositories/detail_repository.dart';

class GetDetailsTvsUseCase extends UseCase<TvShow, int> {
  final DetailRepository repository;

  GetDetailsTvsUseCase(this.repository);

  @override
  Future<Either<Failure, TvShow>> call(int params) async {
    return await repository.getDetailsTv(movieId: params);
  }
}
