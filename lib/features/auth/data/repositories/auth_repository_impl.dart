import 'package:movie_app/features/auth/data/remote/data_sources/auth_remote_data_source.dart';
import 'package:movie_app/features/auth/data/remote/models/request_token_model.dart';
import 'package:movie_app/features/auth/data/remote/models/request_token_model.dart';
import 'package:movie_app/features/auth/data/remote/models/session_model.dart';
import 'package:movie_app/features/auth/domain/entities/session.dart';
import 'package:movie_app/features/auth/domain/repositories/auth_repository.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String> getRequestToken() async {
    final RequestTokenModel requestToken =
        await remoteDataSource.getRequestToken();
    return requestToken.requestToken;
  }

  @override
  Future<Session> createSession(String requestToken) async {
    final SessionModel sessionModel =
        await remoteDataSource.createSession(requestToken);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("session_id", sessionModel.sessionId);

    return Session(sessionId: sessionModel.sessionId);
  }

  @override
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("session_id");
    return true;
  }

  @override
  Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("session_id");
  }
}
