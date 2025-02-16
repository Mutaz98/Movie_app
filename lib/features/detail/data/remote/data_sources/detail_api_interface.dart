import 'package:dio/dio.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'detail_api_interface.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class DetailAPIInterface {
  factory DetailAPIInterface(Dio dio) {
    return _DetailAPIInterface(dio);
  }

  @GET("tv/{id}")
  Future<TvShow> getDetailsTv({
    @Query('api_key') required String apiKey,
    @Path('id') required int movieId, // Movie ID parameter
  });

  @GET("movie/{id}")
  Future<MovieDetailsModel> getDetailsMovie({
    @Query('api_key') required String apiKey,
    @Path('id') required int movieId, // Movie ID parameter
  });
}
