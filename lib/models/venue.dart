import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'venue.g.dart';

// See documentation here https://docs.flutter.dev/data-and-backend/serialization/json#creating-model-classes-the-json_serializable-way
// After changing this class, it is essential to run `dart run build_runner build --delete-conflicting-outputs` from the root of the project.

/// This class defines what a venue object is, what are its required fields
/// and what are some optional fields it contains.
@JsonSerializable()
class Venue {
  Venue(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.hasPatio,
      required this.url, this.image});

  final String name;
  final double latitude;
  final double longitude;
  final String url;
  String? image;
  String? imageDescription;
  String? cuisine;
  double? rating;

  @JsonKey(name: 'has_patio')
  final bool hasPatio;

  /// This autogenerates some code from JSON to list with the given parameters in the function.
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);

  /// This calcualtes the distance between a venue and a given latitude and longitude.
  /// Parameters:
  ///   - latitude: the required latitutde
  ///   - longitude: the required longitude
  double distanceFrom({required double latitude, required double longitude}) {
    return sqrt(pow(latitude - this.latitude, 2) + pow(longitude - this.longitude, 2));
  }

  /// This converts the distance between a venue and a given latitude and longitude into meters
  /// Parameters:
  ///   - latitude: the required latitutde
  ///   - longitude: the required longitude
  double distanceInMeters(
      {required double latitude, required double longitude}) {
    return 111139 * distanceFrom(latitude: latitude, longitude: longitude);
  }
}
