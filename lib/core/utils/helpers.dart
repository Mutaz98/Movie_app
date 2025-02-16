import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/domain/model/app_api_response.dart';
import 'package:movie_app/core/data/remote/dto/api_dto.dart';

import 'package:movie_app/core/domain/model/app_api_response.dart';
import 'package:movie_app/core/domain/model/failure.dart';

import 'package:movie_app/core/utils/api_global.dart';

import 'package:flutter/material.dart';
import 'package:movie_app/features/auth/data/remote/models/request_token_model.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';

APPApiResponse handleSuccess<T>(T response) {
  dynamic rawRes;
  if (response is APIResponse) {
    rawRes = response.results;
  } else {
    rawRes = response;
  }

  final APPApiResponse appApiResponse = APPApiResponse();
  appApiResponse.body = rawRes;
  return appApiResponse;
}

APPApiResponse handleError(dynamic e) {
  final APPApiResponse appApiResponse = APPApiResponse();
  appApiResponse.error = e;
  return appApiResponse;
}

Future<APPApiResponse> getAppApiResponse<T>(Future apiCall) async {
  try {
    final response = await apiCall;

    return handleSuccess(response);
  } on DioException catch (e) {
    return handleError(e.response?.data);
  } catch (e) {
    return handleError(e.toString());
  }
}

Future<Either<Failure, T>> getRepositoryResponse<T, E>(
  Future<APPApiResponse> call,
) async {
  final res = await call;
  if (res.body != null) {
    return Right(getResFromJson<T, E>(res.body));
  } else if (res.error != null) {
    if (res.error is String) {
      return Left(ServerFailure(message: res.error as String));
    } else {
      try {
        final apiError = APIError.fromJson(res.error as Map<String, dynamic>);
        if (apiError.status == 422) {
          return Left(ServerCustomFailure(message: apiError.errors, type: 1));
        } else {
          return Left(ServerFailure(message: apiError.errors));
        }
      } on Exception catch (_) {
        return const Left(
            ServerFailure(message: 'An error occurred. Please try again'));
      }
    }
  } else {
    return const Left(
        ServerFailure(message: 'An error occurred. Please try again'));
  }
}

T getResFromJson<T, E>(dynamic body) {
  late T theT;
  switch (T) {
    case RequestTokenModel:
      {
        theT = RequestTokenModel.fromJson(body as Map<String, dynamic>) as T;
        break;
      }
    case const (List<MovieModel>):
      {
        theT = (body as List<dynamic>)
            .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList() as T;
        break;
      }
    default:
      {
        theT = ApiGlobal(body: true) as T;
      }
  }

  return theT;
}

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
}

Dio get appDio {
  final Dio dio = Dio();
  dio.options = BaseOptions(
    connectTimeout: const Duration(seconds: 1000),
    receiveTimeout: const Duration(seconds: 1000),
    sendTimeout: const Duration(seconds: 1000),
    contentType: 'application/json',
  );

  // dio.interceptors.add(ConnInterceptor(dio));

  return dio;
}

class IntentionalNullValuesWrapper<T> {
  final T? value;

  const IntentionalNullValuesWrapper(this.value);
}
