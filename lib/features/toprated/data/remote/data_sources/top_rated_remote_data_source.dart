import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/core/data/remote/dto/api_dto.dart';
import 'package:movie_app/core/domain/model/app_api_response.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/core/utils/helpers.dart';
import 'package:movie_app/features/toprated/data/remote/data_sources/top_rated_api_interface.dart';

abstract class TopRatedRemoteDataSource {
  Future<APPApiResponse> getTopRatedMovies({
    required int page,
  });

  Future<APPApiResponse> searchMovieTopRated(
      {required int page, required String query});
}

class TopRatedRemoteDataSourceImpl implements TopRatedRemoteDataSource {
  final TopRatedAPIInterface apiService;

  TopRatedRemoteDataSourceImpl(this.apiService);

  @override
  Future<APPApiResponse> getTopRatedMovies({required int page}) async {
    return getAppApiResponse<APIResponse>(
        apiService.getTopRatedMovies(page: page, apiKey: apiKey));
  }

  @override
  Future<APPApiResponse> searchMovieTopRated(
      {required int page, required String query}) {
    return getAppApiResponse<APIResponse>(apiService.searchMovieTopRated(
        page: page, apiKey: apiKey, query: query));
  }
}
