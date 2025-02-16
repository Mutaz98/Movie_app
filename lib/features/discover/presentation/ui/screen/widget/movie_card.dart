import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/discover/data/remote/models/movie_model.dart';
import 'package:movie_app/features/favourite/domain/entities/movie_model_local.dart';
import 'package:movie_app/features/favourite/presentation/manager/cubit.dart';
import 'package:movie_app/features/favourite/presentation/manager/event.dart';
import 'package:movie_app/features/favourite/presentation/manager/state.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final VoidCallback onTap;
  final int type;
  final VoidCallback onFavoriteTap; // Callback for favorite action

  MovieCard(
      {required this.movie,
      required this.type,
      required this.onTap,
      required this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieFavoriteBloc, MovieFavoriteState>(
      builder: (context, uIstate) {
        bool isFavorite = false;

        if (uIstate is MovieFavoriteListLoaded) {
          isFavorite = uIstate.favorites.any((m) => m.id == movie.id);
        }
        return GestureDetector(
          onTap: onTap,
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: movie.posterPath != null
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              title: Text(
                type == 1 ? movie.title ?? "No Title" : movie.name ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: type == 1
                  ? Text("Release: ${movie.releaseDate ?? "Unknown"}")
                  : const SizedBox.shrink(),
              trailing: type == 1
                  ? IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context.read<MovieFavoriteBloc>().add(
                                RemoveFromFavoritesEvent(movie.id!),
                              );
                        } else {
                          context.read<MovieFavoriteBloc>().add(
                                AddToFavoritesEvent(
                                  MovieModelLocal(
                                    id: movie.id!,
                                    title: movie.title ?? "",
                                    posterPath: movie.posterPath ?? "",
                                    releaseDate: movie.releaseDate ?? "",
                                    overview: movie.overview ?? "",
                                  ),
                                ),
                              );
                        }
                      },
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}
