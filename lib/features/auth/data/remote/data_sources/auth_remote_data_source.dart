import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/features/auth/data/remote/data_sources/auth_api_interface.dart';
import 'package:movie_app/features/auth/data/remote/models/request_token_model.dart';

import 'package:movie_app/features/auth/data/remote/models/session_model.dart';

abstract class AuthRemoteDataSource {
  Future<RequestTokenModel> getRequestToken();
  Future<SessionModel> createSession(String requestToken);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthAPIInterface apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<RequestTokenModel> getRequestToken() async {
    return await apiService.getRequestToken(apiKey);
  }

  @override
  Future<SessionModel> createSession(String requestToken) async {
    return await apiService.createSession({"request_token": requestToken});
  }
}
