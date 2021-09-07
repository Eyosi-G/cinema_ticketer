import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  String id;
  final String title;
  final double duration;
  @JsonKey(name: 'release_date')
  final DateTime releaseDate;
  final List<String> casts;
  final String summary;
  final String language;
  @JsonKey(name: 'cover_image')
  final String coverImage;
  @JsonKey(name: 'comming_soon')
  final bool comingSoon;
  Movie({
    this.title,
    this.coverImage,
    this.duration,
    this.casts,
    this.comingSoon,
    this.language,
    this.releaseDate,
    this.summary,
  });
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
