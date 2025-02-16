import 'package:dio/dio.dart';
import 'package:movie_app/core/data/remote/dto/api_dto.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'top_rated_api_interface.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TopRatedAPIInterface {
  factory TopRatedAPIInterface(Dio dio) {
    return _TopRatedAPIInterface(dio);
  }

  @GET("movie/top_rated")
  Future<APIResponse> getTopRatedMovies({
    @Query('api_key') required String apiKey,
    @Query('page') required int page, // Add page parameter
  });

  @GET("search/movie")
  Future<APIResponse> searchMovieTopRated({
    @Query('query') required String query,
    @Query('api_key') required String apiKey,
    @Query('page') required int page,
  });
}
