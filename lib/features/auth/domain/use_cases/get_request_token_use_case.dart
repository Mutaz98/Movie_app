import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';

class GetRequestTokenUseCase {
  final AuthRepository repository;
  GetRequestTokenUseCase(this.repository);

  Future<String> call() => repository.getRequestToken();
}
