// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      hasPatio: json['has_patio'] as bool,
      url: json['url'] as String,
      image: json['image'] as String?,
    )
      ..imageDescription = json['imageDescription'] as String?
      ..cuisine = json['cuisine'] as String?
      ..rating = (json['rating'] as num?)?.toDouble();

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'url': instance.url,
      'image': instance.image,
      'imageDescription': instance.imageDescription,
      'cuisine': instance.cuisine,
      'rating': instance.rating,
      'has_patio': instance.hasPatio,
    };
