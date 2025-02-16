import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/core/presentation/ui/widget/empty_view.dart';
import 'package:movie_app/features/detail/presentation/ui/screen/details_screen.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/toprated/presentation/manager/top_rated_cubit.dart';

import '../../../../discover/presentation/ui/screen/widget/movie_card.dart';

class TopRatedScreen extends StatefulWidget {
  @override
  _TopRatedScreenState createState() => _TopRatedScreenState();
}

class _TopRatedScreenState extends State<TopRatedScreen>
    with SingleTickerProviderStateMixin {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      context
          .read<TopRatedCubit>()
          .fetchData(page, _pagingController, _searchController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Top Rated Movies"),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search Movies...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          if (_searchController.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            _searchController.clear();
                            _pagingController.refresh();
                            context
                                .read<TopRatedCubit>()
                                .refreshData(_pagingController, '');
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
                      context.read<TopRatedCubit>().refreshData(
                          _pagingController, _searchController.text);
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
                    type: 1,
                    movie: movie,
                    onFavoriteTap: () {},
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            movieId: movie.id!,
                          ),
                        ),
                      );
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
        ]));
  }
}

// class MovieCard extends StatelessWidget {
//   final MovieModel movie;
//   final VoidCallback onTap;

//   final VoidCallback onFavoriteTap; // Callback for favorite action

//   MovieCard(
//       {required this.movie, required this.onTap, required this.onFavoriteTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         elevation: 5,
//         child: ListTile(
//             contentPadding: const EdgeInsets.all(10),
//             leading: movie.posterPath != null
//                 ? Image.network(
//                     'https://image.tmdb.org/t/p/w200${movie.posterPath}',
//                     width: 100,
//                     fit: BoxFit.cover,
//                   )
//                 : const SizedBox.shrink(),
//             title: Text(
//               movie.title ?? "No Title",
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//               ),
//             ),
//             subtitle: Text("Release: ${movie.releaseDate ?? "Unknown"}")

//             //  IconButton(
//             //         icon: Icon(
//             //           isFavorite ? Icons.favorite : Icons.favorite_border,
//             //           color: isFavorite ? Colors.red : Colors.grey,
//             //         ),
//             //         onPressed: () {
//             //           if (isFavorite) {
//             //             context.read<MovieFavoriteBloc>().add(
//             //                   RemoveFromFavoritesEvent(movie.id!),
//             //                 );
//             //           } else {
//             //             context.read<MovieFavoriteBloc>().add(
//             //                   AddToFavoritesEvent(
//             //                     MovieModelLocal(
//             //                       id: movie.id!,
//             //                       title: movie.title ?? "",
//             //                       posterPath: movie.posterPath ?? "",
//             //                       releaseDate: movie.releaseDate ?? "",
//             //                       overview: movie.overview ?? "",
//             //                     ),
//             //                   ),
//             //                 );
//             //           }
//             //         },
//             //       )
//             //     : null,
//             ),
//       ),
//     );
//   }
// }
