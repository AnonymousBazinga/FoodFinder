import 'dart:convert';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:http/http.dart' as http;
import 'package:food_finder/weather_conditions.dart';

//ignore_for_file: avoid_print

// this class fetches data from the NWS Gov website API
// It sets the location to the Allen Center and retrieves the weather conditions
class WeatherChecker {
  final WeatherProvider weatherProvider;
  double _latitude = 47.96649; //Allen Center is here, per Google Maps
  double _longitude = -122.34318;
  final http.Client client;

  // the constructor connects to a weather provider and has an optional
  // parameter which initiates a connection with the API client
  WeatherChecker(this.weatherProvider, [http.Client? client])
      : client = client ?? http.Client();

  /// This contains updates the location if sent new base locations to work with.
  /// Parameters:
  ///   - The new latitude
  ///   - The new longitude to be updated with.
  void updateLocation(double latitude, double longitude) {
    _latitude = latitude;
    _longitude = longitude;
  }

  /// Updates the weather client with the weather state from the gov API
  /// Parameters: none
  /// Returns: a Future promise of a void.
  Future<void> fetchAndUpdateCurrentSeattleWeather() async {
    try {
      final gridResponse = await client.get(
          Uri.parse('https://api.weather.gov/points/$_latitude,$_longitude'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          print(
              'Got the weather at ${DateTime.now()}. $temperature F and $shortForecast'); // records time of retrieval
          if (temperature != null && shortForecast != null) {
            final condition = _shortForecastToCondition(shortForecast);
            weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (_) {
      weatherProvider.hasReceived = false; // this tells the user that the app has not loaded yet
    } finally {
      client.close();
    }
  }

  /// Helper function to format the forecast retrieved from the API into an object
  /// which can be processed in weather Provider.
  /// Parameters:
  ///   - The ShortForecast which needs to be converted into one of the 3 Weather condition types.
  /// Returns: a weather condition type.
  WeatherCondition _shortForecastToCondition(String shortForecast) {
    final lowercased = shortForecast.toLowerCase();
    if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
    if (lowercased.startsWith('sun') || lowercased.startsWith('partly')) {
      return WeatherCondition.sunny;
    }
    return WeatherCondition.gloomy;
  }
}
