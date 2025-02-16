import 'package:dio/dio.dart';
import 'package:movie_app/core/data/remote/dto/api_dto.dart';
import 'package:movie_app/core/utils/constants.dart';

import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'discover_api_interface.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class DiscoverAPIInterface {
  factory DiscoverAPIInterface(Dio dio) {
    return _DiscoverAPIInterface(dio);
  }

  @GET("discover/movie")
  Future<APIResponse> getDiscoverMovies({
    @Query('api_key') required String apiKey,
    @Query('page') required int page, // Add page parameter
  });

  @GET("search/movie")
  Future<APIResponse> searchMovie({
    @Query('query') required String query,
    @Query('api_key') required String apiKey,
    @Query('page') required int page,
  });

  @GET("search/tv")
  Future<APIResponse> searchTv({
    @Query('query') required String query,
    @Query('api_key') required String apiKey,
    @Query('page') required int page,
  });

  @GET("discover/tv")
  Future<APIResponse> getDiscoverTvShows({
    @Query('api_key') required String apiKey,
    @Query('page') required int page, // Add page parameter
  });
}
