import 'package:movie_app/features/auth/domain/entities/session.dart';

abstract class AuthRepository {
  Future<String> getRequestToken();
  Future<Session> createSession(String requestToken);
  Future<bool> logout();
  Future<String?> getSessionId();
}
