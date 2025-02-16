import 'package:movie_app/core/data/remote/dto/api_dto.dart';
import 'package:movie_app/core/domain/model/app_api_response.dart';
import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/core/utils/helpers.dart';
import 'package:movie_app/features/discover/data/remote/data_sources/discover_api_interface.dart';

abstract class DiscoverRemoteDataSource {
  Future<APPApiResponse> getDiscoverMovies({
    required int page,
  });
  Future<APPApiResponse> getSearchMovie(
      {required int page, required String query});
  Future<APPApiResponse> getSearchTv(
      {required int page, required String query});
  Future<APPApiResponse> getDiscoverTvShows({required int page});
}

class DiscoverRemoteDataSourceImpl implements DiscoverRemoteDataSource {
  final DiscoverAPIInterface apiService;

  DiscoverRemoteDataSourceImpl(this.apiService);

  @override
  Future<APPApiResponse> getDiscoverMovies({required int page}) async {
    return getAppApiResponse<APIResponse>(
        apiService.getDiscoverMovies(page: page, apiKey: apiKey));
  }

  @override
  Future<APPApiResponse> getDiscoverTvShows({required int page}) async {
    return getAppApiResponse<APIResponse>(
        apiService.getDiscoverTvShows(page: page, apiKey: apiKey));
  }

  @override
  Future<APPApiResponse> getSearchMovie(
      {required int page, required String query}) {
    return getAppApiResponse<APIResponse>(
        apiService.searchMovie(page: page, apiKey: apiKey, query: query));
  }

  @override
  Future<APPApiResponse> getSearchTv(
      {required int page, required String query}) {
    return getAppApiResponse<APIResponse>(
        apiService.searchTv(page: page, apiKey: apiKey, query: query));
  }
}
