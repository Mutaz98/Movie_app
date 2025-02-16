import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/presentation/ui/widget/app_widgets.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_cubit.dart';
import 'package:movie_app/features/detail/presentation/manager/detail_state.dart';

class DetailsTvShowsPage extends StatefulWidget {
  final int movieId;

  const DetailsTvShowsPage({
    super.key,
    required this.movieId,
  });

  @override
  State<DetailsTvShowsPage> createState() => _DetailsTvShowsPageState();
}

class _DetailsTvShowsPageState extends State<DetailsTvShowsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch TV show details
    context.read<DetailCubit>().fetchTvDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return _buildLoadingState();
          } else if (state is DetailTvDetailsLoaded) {
            return _buildTvDetails(state.tvShows);
          } else if (state is DetailError) {
            return _buildErrorState(state.message);
          } else {
            return _buildUnknownState();
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
      title: const Text("TV Show Details"),
      backgroundColor: Colors.black.withOpacity(0.6), // Customize as needed
    );
  }

  Widget _buildLoadingState() {
    return Center(child: LoadingWidget());
  }

  Widget _buildTvDetails(dynamic movieDetails) {
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
                _buildPoster(movieDetails.posterPath),
                const SizedBox(height: 20),
                _buildTitle(movieDetails.name),
                const SizedBox(height: 10),
                _buildGenres(movieDetails.genres),
                const SizedBox(height: 20),
                _buildInfoRow(
                    "First Air Date", movieDetails.firstAirDate ?? "Unknown"),
                const SizedBox(height: 10),
                _buildInfoRow("Number of Seasons",
                    movieDetails.numberOfSeasons?.toString() ?? "0"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPoster(String? posterPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        'https://image.tmdb.org/t/p/w500${posterPath ?? ""}',
        width: double.infinity,
        height: 300,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
              child: Icon(Icons.error, size: 50, color: Colors.red));
        },
      ),
    );
  }

  Widget _buildTitle(String? title) {
    return Text(
      title ?? "Unknown Title",
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildGenres(List<dynamic>? genres) {
    return Wrap(
      spacing: 10,
      children: genres?.map((genre) {
            return Chip(
              label: Text(
                genre.name ?? "Unknown",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orangeAccent,
            );
          }).toList() ??
          [],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Text(
      "$label: $value",
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red, fontSize: 18),
      ),
    );
  }

  Widget _buildUnknownState() {
    return const Center(
      child: Text(
        "Something went wrong.",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
