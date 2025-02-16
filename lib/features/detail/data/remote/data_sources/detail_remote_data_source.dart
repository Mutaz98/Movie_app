import 'package:movie_app/core/utils/constants.dart';
import 'package:movie_app/features/detail/data/remote/data_sources/detail_api_interface.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/data/remote/models/tv_show_details_model.dart';

abstract class DetailRemoteDataSource {
  Future<MovieDetailsModel> getDetailsMovie({
    required int movieId,
  });
  Future<TvShow> getDetailsTv({
    required int movieId,
  });
}

class DetailRemoteDataSourceImpl implements DetailRemoteDataSource {
  final DetailAPIInterface apiService;

  DetailRemoteDataSourceImpl(this.apiService);

  @override
  Future<MovieDetailsModel> getDetailsMovie({
    required int movieId,
  }) async {
    return apiService.getDetailsMovie(apiKey: apiKey, movieId: movieId);
  }

  @override
  Future<TvShow> getDetailsTv({required int movieId}) {
    return apiService.getDetailsTv(apiKey: apiKey, movieId: movieId);
  }
}
