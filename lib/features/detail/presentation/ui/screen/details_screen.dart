import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/presentation/ui/widget/app_widgets.dart';
import 'package:movie_app/features/detail/data/remote/models/movie_details_model.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_cubit.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_state.dart';
import 'package:movie_app/features/detail/presentation/ui/screen/widget/star_rating.dart';

class DetailsPage extends StatefulWidget {
  final int movieId;

  const DetailsPage({
    super.key,
    required this.movieId,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailCubit>().fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return _buildLoading();
          } else if (state is DetailMovieDetailsLoaded) {
            return _buildMovieDetails(state.tvShows, state.rating);
          } else if (state is DetailError) {
            return _buildError(state.message);
          } else {
            return _buildError("Something went wrong.");
          }
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous screen
        },
      ),
      title: const Text("Movie Details"),
      backgroundColor: Colors.black.withOpacity(0.6),
    );
  }

  Widget _buildLoading() {
    return Center(child: LoadingWidget());
  }

  Widget _buildMovieDetails(MovieDetailsModel movieDetails, double rating) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black.withOpacity(0.6), Colors.transparent],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMoviePoster(movieDetails.posterPath),
                const SizedBox(height: 20),
                _buildMovieTitle(movieDetails.originalTitle),
                const SizedBox(height: 10),
                _buildReleaseDate(movieDetails.releaseDate),
                const SizedBox(height: 10),
                _buildGenres(movieDetails.genres),
                const SizedBox(height: 20),
                _buildBudget(movieDetails.budget),
                const SizedBox(height: 20),
                _buildOverview(movieDetails.overview),
                const SizedBox(height: 20),
                _buildRatingSection(rating),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoviePoster(String? posterPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://image.tmdb.org/t/p/w500$posterPath',
        width: double.infinity,
        height: 300,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildMovieTitle(String? title) {
    return Text(
      title ?? '',
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildReleaseDate(String? releaseDate) {
    return releaseDate != null
        ? Text(
            "Release Date: $releaseDate",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          )
        : const SizedBox.shrink();
  }

  Widget _buildGenres(List<Genre>? genres) {
    return Wrap(
      spacing: 10,
      children: genres?.map((genre) {
            return Chip(
              label: Text(
                genre.name,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orangeAccent,
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildBudget(int? budget) {
    return Text(
      "Budget: \$${budget ?? 0}",
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOverview(String? overview) {
    return Text(
      overview ?? "No Overview Available",
      style: const TextStyle(fontSize: 16, color: Colors.black),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildRatingSection(double rating) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Rate this Movie",
            style: TextStyle(fontSize: 18, color: Colors.black)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StarRating(
              rating: rating,
              onRatingUpdate: (newRating) {
                context
                    .read<DetailCubit>()
                    .setRating(widget.movieId, newRating);
              },
            ),
            if (rating > 0)
              TextButton(
                onPressed: () {
                  context.read<DetailCubit>().setRating(widget.movieId, 0);
                },
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Delete Rating',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }
}
