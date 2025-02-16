import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';

abstract class DetailRepository {
  Future<Either<Failure, MovieDetailsModel>> getDetailsMovie({
    required int movieId,
  });

  Future<Either<Failure, TvShow>> getDetailsTv({
    required int movieId,
  });
}
