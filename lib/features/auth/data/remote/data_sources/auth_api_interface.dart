import 'package:dio/dio.dart';

import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/features/auth/data/remote/models/request_token_model.dart';

import 'package:movie_app/features/auth/data/remote/models/session_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_api_interface.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AuthAPIInterface {
  factory AuthAPIInterface(Dio dio) {
    return _AuthAPIInterface(dio);
  }

  @GET("authentication/token/new")
  Future<RequestTokenModel> getRequestToken(@Query("api_key") String apiKey);

  @POST("authentication/session/new")
  Future<SessionModel> createSession(@Body() Map<String, dynamic> body);
}
