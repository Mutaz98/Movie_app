import 'package:dartz/dartz.dart';
import 'package:movie_app/core/domain/model/failure.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseStream<Type, Params> {
  Stream call(Params params);
}

abstract class UseCaseNoAsync<Type, Params> {
  Either<Failure, Type> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
