import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/toprated/domain/use_cases/get_search_top_rated_use_case.dart';
import 'package:movie_app/features/toprated/domain/use_cases/get_top_rated_tv_use_case.dart';
import 'package:movie_app/features/toprated/presentation/manager/top_rated_state.dart';

class TopRatedCubit extends Cubit<TopRatedState> {
  final GetDiscoverTopRatedUseCase getDiscoverTopRatedUseCase;
  final GetSearchMoviesTopRatedUseCase getSearchMoviesTopRatedUseCase;

  TopRatedCubit({
    required this.getDiscoverTopRatedUseCase,
    required this.getSearchMoviesTopRatedUseCase,
  }) : super(TopRatedInitial());

  int currentPage = 1;
  bool isFetching = false;
  String currentQuery = '';

  Future<void> fetchData(int page, PagingController<int, MovieModel> controller,
      [String query = '']) async {
    if (isFetching) return; // Prevent duplicate requests
    isFetching = true;

    final result = (query.isEmpty)
        ? await getDiscoverTopRatedUseCase(page) // Fetch Discover Movies

        : await getSearchMoviesTopRatedUseCase(
            GetMovieTopRatedSearch(page: page, query: query));

    result.fold(
      (failure) {
        controller.error = failure.message;
      },
      (data) {
        final isLastPage = data.length < 20; // Adjust based on API response
        if (isLastPage) {
          controller.appendLastPage(data);
        } else {
          controller.appendPage(data, page + 1);
        }
      },
    );

    isFetching = false;
  }

  void refreshData(PagingController<int, MovieModel> controller, String query) {
    currentQuery = query;
    currentPage = 1;
    controller.refresh();
    fetchData(currentPage, controller, query);
  }
}
