import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

// General failures
class LocalFailure extends Failure {
  const LocalFailure({required String message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}

class ServerCustomFailure extends Failure {
  final int type;

  const ServerCustomFailure({required String message, required this.type})
      : super(message: message);

  @override
  List<Object?> get props => [message, type];
}

class CacheFailure extends Failure {
  const CacheFailure() : super(message: '');

  @override
  List<Object?> get props => [message];
}
