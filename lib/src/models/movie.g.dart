// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    title: json['title'] as String,
    coverImage: json['cover_image'] as String,
    duration: (json['duration'] as num)?.toDouble(),
    casts: (json['casts'] as List)?.map((e) => e as String)?.toList(),
    comingSoon: json['comming_soon'] as bool,
    language: json['language'] as String,
    releaseDate: json['release_date'] == null
        ? null
        : DateTime.parse(json['release_date'] as String),
    summary: json['summary'] as String,
  )..id = json['id'] as String;
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'release_date': instance.releaseDate?.toIso8601String(),
      'casts': instance.casts,
      'summary': instance.summary,
      'language': instance.language,
      'cover_image': instance.coverImage,
      'comming_soon': instance.comingSoon,
    };
