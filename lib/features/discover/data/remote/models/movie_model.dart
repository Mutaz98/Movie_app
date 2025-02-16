import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';
part 'movie_model.g.dart';

@freezed
class MovieModel with _$MovieModel {
  factory MovieModel({
    final int? id,
    @JsonKey(name: 'original_language') final String? originalLanguage,
    @JsonKey(name: 'original_title') final String? originalTitle,
    final String? overview,
    final double? popularity,
    @JsonKey(name: 'poster_path') final String? posterPath,
    @JsonKey(name: 'release_date') final String? releaseDate,
    final String? title,
    final bool? video,
    @JsonKey(name: 'vote_average') final double? voteAverage,
    @JsonKey(name: 'vote_count') final int? voteCount,
    String? name,
    double? userRating,
  }) = _MovieModel;

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);
}
