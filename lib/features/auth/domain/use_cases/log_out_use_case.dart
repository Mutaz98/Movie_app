import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository repository;
  LogOutUseCase(this.repository);

  Future<bool> call() => repository.logout();
}
