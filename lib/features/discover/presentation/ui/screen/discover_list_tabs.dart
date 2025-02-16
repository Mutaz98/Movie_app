import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/core/presentation/ui/widget/empty_view.dart';
import 'package:movie_app/features/detail/presentation/ui/screen/detail_screen_tv_shows.dart';
import 'package:movie_app/features/detail/presentation/ui/screen/details_screen.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/discover/presentation/manager/discover_cubit.dart';
import 'package:movie_app/features/discover/presentation/ui/screen/widget/movie_card.dart';

class DiscoverList extends StatefulWidget {
  final int type; // 1 for Movies, 2 for TV Shows

  const DiscoverList({required this.type, Key? key}) : super(key: key);

  @override
  _DiscoverListState createState() => _DiscoverListState();
}

class _DiscoverListState extends State<DiscoverList> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      context.read<DiscoverCubit>().fetchData(
          widget.type, page, _pagingController, _searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: widget.type == 1
                        ? 'Search Movies...'
                        : 'Search Tv show...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        if (_searchController.text.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          _searchController.clear();
                          _pagingController.refresh();
                          context
                              .read<DiscoverCubit>()
                              .refreshData(widget.type, _pagingController, '');
                        }
                      },
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _pagingController.refresh();
                    context.read<DiscoverCubit>().refreshData(
                        widget.type, _pagingController, _searchController.text);
                  },
                  child: const Text("Search"))
            ],
          ),
        ),
        Expanded(
          child: PagedListView<int, MovieModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<MovieModel>(
              itemBuilder: (context, movie, index) => MovieCard(
                  movie: movie,
                  type: widget.type,
                  onFavoriteTap: () {},
                  onTap: () {
                    if (widget.type == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            movieId: movie.id!,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsTvShowsPage(
                            movieId: movie.id!,
                          ),
                        ),
                      );
                    }
                  }),
              firstPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              newPageProgressIndicatorBuilder: (context) =>
                  const Center(child: CircularProgressIndicator()),
              noItemsFoundIndicatorBuilder: (context) => const EmptyView(
                content: "No Items Found",
                icon: Icons
                    .search_off, // This icon indicates no results were found
              ),
              noMoreItemsIndicatorBuilder: (_) => const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
