import 'package:flutter/material.dart';
import 'package:food_finder/weather_conditions.dart';

/// This class is a weather provider which extends a changeNotifier.
/// It can be used to update any data for all consumers
class WeatherProvider extends ChangeNotifier {
  bool hasReceived = false;
  int tempInfahrenheit = 0;
  WeatherCondition condition = WeatherCondition.unknown;

  /// This contains notifyListeners which updates all its consumers.
  /// Parameters:
  ///   - The new temperature in fahrenheit to be updated with
  ///   - The new weather condition to be updated with.
  void updateWeather(int newTempfahrenheit, WeatherCondition newCondition){
    hasReceived = true;
    tempInfahrenheit = newTempfahrenheit;
    condition = newCondition;
    notifyListeners();
  }
}