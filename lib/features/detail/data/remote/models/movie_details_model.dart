import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_model.freezed.dart';
part 'movie_details_model.g.dart';

@freezed
class MovieDetailsModel with _$MovieDetailsModel {
  factory MovieDetailsModel({
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'budget') int? budget,
    @JsonKey(name: 'homepage') String? homepage,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'imdb_id') String? imdbId,
    @JsonKey(name: 'genres') List<Genre>? genres, // List of Genre objects
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_title') String? originalTitle,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'popularity') double? popularity,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'release_date') String? releaseDate,
    @JsonKey(name: 'revenue') int? revenue,
    @JsonKey(name: 'runtime') int? runtime,
    @JsonKey(name: 'status') String? status,
    String? title,
    @JsonKey(name: 'vote_average') double? voteAverage,
    @JsonKey(name: 'vote_count') double? voteCount,
    String? name,
  }) = _MovieDetailsModel;

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);
}

@freezed
class Genre with _$Genre {
  factory Genre({
    required int id,
    required String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
