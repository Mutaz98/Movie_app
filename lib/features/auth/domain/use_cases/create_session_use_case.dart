import 'package:movie_app/features/auth/domain/entities/session.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';

class CreateSession {
  final AuthRepository repository;
  CreateSession(this.repository);

  Future<Session> call(String requestToken) =>
      repository.createSession(requestToken);
}
