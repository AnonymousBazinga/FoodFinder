import 'dart:convert';
import 'package:food_finder/models/venue.dart';

/// This class defines a VenuesDB object which includes a list of Venue objects
class VenuesDB {
  final List<Venue> _venues;

  /// This is a simpel get request to retrieve all the venues as stored in VenuesDB
  List<Venue> get all {
    return List<Venue>.from(_venues, growable: false);
  }

  /// This provides a list of length max containing the max nearest places to the given lat and long.
  /// Parameters:
  ///   - max: by default set to 999 and is the number of nearest venues to retrieve
  ///   - latitutde: the latitude
  ///   - longitude: the longitude
  /// Returns:
  ///   - The list with n nearest venues.
  List<Venue> nearestTo({int max = 999, required double latitude, required double longitude}) {
    _venues.sort((a, b) {
      final double distanceA = a.distanceFrom(latitude: latitude, longitude: longitude);
      final double distanceB = b.distanceFrom(latitude: latitude, longitude: longitude);
      return distanceA.compareTo(distanceB);
    });
    return _venues.take(max).toList();
  }

  /// This method initalizes a VenuesDB object from a JSON string
  /// Parameters:
  ///   - takes in the JSON string
  /// Returns:
  ///   - a List of Venues that defines the VenuesDB object.
  VenuesDB.initializeFromJson(String jsonString)
      : _venues = _decodeVenueListJson(jsonString);

  static List<Venue> _decodeVenueListJson(String jsonString) {
    final listMap = jsonDecode(jsonString);
    final theList = (listMap as List).map((element) {
      return Venue.fromJson(element);
    }).toList();
    return theList;
  }
}
