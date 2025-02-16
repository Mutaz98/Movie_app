import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/presentation/ui/widget/app_widgets.dart';
import 'package:movie_app/core/presentation/ui/widget/empty_view.dart';
import 'package:movie_app/features/detail/presentation/ui/screen/details_screen.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:movie_app/features/favourite/presentation/manager/cubit.dart';
import 'package:movie_app/features/favourite/presentation/manager/event.dart';
import 'package:movie_app/features/favourite/presentation/manager/state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // Load favorites as soon as the screen is loaded
    context.read<MovieFavoriteBloc>().add(GetFavoritesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<MovieFavoriteBloc, MovieFavoriteState>(
        builder: (context, state) {
          if (state is MovieFavoriteLoading) {
            // Show a loading spinner when the data is being fetched
            return Center(child: LoadingWidget());
          } else if (state is MovieFavoriteListLoaded) {
            final favorites = state.favorites;

            if (favorites.isEmpty) {
              // If there are no favorites, show a message
              return const Center(
                child: EmptyView(
                  content: "You don't have any favorite movies.",
                  icon: Icons.movie_creation_outlined,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final movie = favorites[index];
                  return Dismissible(
                    key: Key(movie.id.toString()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      child: const Icon(Icons.delete,
                          color: Colors.white, size: 30),
                    ),
                    onDismissed: (_) {
                      context
                          .read<MovieFavoriteBloc>()
                          .add(RemoveFromFavoritesEvent(movie.id));
                    },
                    child: _buildMovieCard(movie),
                  );
                },
              ),
            );
          } else if (state is MovieFavoriteError) {
            // Display an error message if there was an issue fetching the data
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }
          return const Center(child: SizedBox.shrink());
        },
      ),
    );
  }

  // Helper method to build a card for each movie
  Widget _buildMovieCard(MovieModelLocal movie) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => _navigateToDetailsPage(movie.id),
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          movie.releaseDate,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://image.tmdb.org/t/p/w200${movie.posterPath}',
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeFromFavorites(movie.id),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
    );
  }

  // Navigate to the details screen of the movie
  void _navigateToDetailsPage(int movieId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(
          movieId: movieId,
        ),
      ),
    );
  }

  // Handle removal of a movie from favorites
  void _removeFromFavorites(int movieId) {
    context.read<MovieFavoriteBloc>().add(RemoveFromFavoritesEvent(movieId));
  }
}
