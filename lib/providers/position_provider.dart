import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// This class is a position provider which extends a changeNotifier.
/// It can be used to update any data for all consumers
class PositionProvider extends ChangeNotifier {
  late double latitude;
  late double longitude;
  bool hasPosition = false;
  Timer? _positionTimer;

  // This constructor updates the position every 1 sec
  PositionProvider() {
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await _updatePosition();
    });
  }

  /// This is a helper function to dispose of the timer once the app is no longer in use.
  @override
  void dispose() {
    _positionTimer?.cancel();
    super.dispose();
  }

  // This is a simple getter function that checks if hasPosition is true or false.
  bool get positionKnown {
    return hasPosition;
  }

  /// This contains notifyListeners which updates all its consumers.
  Future<void> _updatePosition() async {
    try {
      final Position currPosition = await _determinePosition(); // Get current position
      latitude = currPosition.latitude; // Update latitude
      longitude = currPosition.longitude; // Update longitude
      hasPosition = true;
    } catch (err) {
      hasPosition = false;
    }
    notifyListeners(); // Notify listeners about the change
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}