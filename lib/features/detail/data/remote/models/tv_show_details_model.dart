import 'package:freezed_annotation/freezed_annotation.dart';
part 'tv_show_details_model.freezed.dart';
part 'tv_show_details_model.g.dart';

@freezed
class TvShow with _$TvShow {
  const factory TvShow({
    @JsonKey(name: 'adult') bool? adult,
    @JsonKey(name: 'backdrop_path') String? backdropPath,
    @JsonKey(name: 'created_by') List<CreatedBy>? createdBy,
    @JsonKey(name: 'episode_run_time') List<int>? episodeRunTime,
    @JsonKey(name: 'first_air_date') String? firstAirDate,
    @JsonKey(name: 'genres') List<Genre>? genres,
    @JsonKey(name: 'homepage') String? homepage,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'in_production') bool? inProduction,
    @JsonKey(name: 'languages') List<String>? languages,
    @JsonKey(name: 'last_air_date') String? lastAirDate,
    @JsonKey(name: 'last_episode_to_air') Episode? lastEpisodeToAir,
    @JsonKey(name: 'next_episode_to_air') Episode? nextEpisodeToAir,
    @JsonKey(name: 'networks') List<Network>? networks,
    @JsonKey(name: 'poster_path') String? posterPath,
    @JsonKey(name: 'number_of_episodes') int? numberOfEpisodes,
    @JsonKey(name: 'number_of_seasons') int? numberOfSeasons,
    @JsonKey(name: 'origin_country') List<String>? originCountry,
    @JsonKey(name: 'original_language') String? originalLanguage,
    @JsonKey(name: 'original_name') String? originalName,
    @JsonKey(name: 'name') String? name,
  }) = _TvShow;

  factory TvShow.fromJson(Map<String, dynamic> json) => _$TvShowFromJson(json);
}

@freezed
class CreatedBy with _$CreatedBy {
  const factory CreatedBy({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'profile_path') String? profilePath,
  }) = _CreatedBy;

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);
}

@freezed
class Genre with _$Genre {
  const factory Genre({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
class Episode with _$Episode {
  const factory Episode({
    @JsonKey(name: 'air_date') String? airDate,
    @JsonKey(name: 'episode_number') int? episodeNumber,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'overview') String? overview,
    @JsonKey(name: 'still_path') String? stillPath,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

@freezed
class Network with _$Network {
  const factory Network({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'logo_path') String? logoPath,
    @JsonKey(name: 'origin_country') String? originCountry,
  }) = _Network;

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);
}
