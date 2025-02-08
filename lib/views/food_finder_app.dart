import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_finder/helpers/weather_checker.dart';
import 'package:food_finder/models/venue.dart';
import 'package:food_finder/models/venues_db.dart';
import 'package:food_finder/providers/position_provider.dart';
import 'package:food_finder/providers/weather_provider.dart';
import 'package:food_finder/views/cart_summary.dart';
import 'package:food_finder/views/food_card.dart';
import 'package:provider/provider.dart';

// This is the main app to display a tinder like interaction but for restuarants and food.
// it includes semantics and the appropriate accessibility features.
class FoodFinderApp extends StatefulWidget {
  final VenuesDB venues;

  const FoodFinderApp({super.key, required this.venues});

  @override
  State<FoodFinderApp> createState() => _FoodFinderAppState();
}

class _FoodFinderAppState extends State<FoodFinderApp> {
  late final Timer _checkerTimer;
  int counter = 0;
  List<Venue> cart = [];

  /// This is a function that initializes the state of the widget tree
  @override
  void initState() {
    super.initState();
    final singleUseWeatherProvider = Provider.of<WeatherProvider>(context, listen: false);
    final WeatherChecker weatherChecker = WeatherChecker(singleUseWeatherProvider);

    weatherChecker.fetchAndUpdateCurrentSeattleWeather();
    _checkerTimer = Timer.periodic(const Duration(seconds: 60), (timer) {
      weatherChecker.fetchAndUpdateCurrentSeattleWeather();
    });
  }

  /// This is a helper function to dispose of the timer once the app is no longer in use.
  @override
  void dispose() {
    _checkerTimer.cancel();
    super.dispose();
  }

  /// This is a the main widget tree that displays the tinder style UI for restaurants
  /// Parameters:
  ///   - context: The build context for the widget tree
  /// Returns:
  ///   - A material app widget containing a black scaffold and various card/ image views
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Consumer2<PositionProvider, WeatherProvider>(
            builder: (context, positionProvider, weatherProvider, child) {
              final weatherChecker = WeatherChecker(weatherProvider);
              List<Venue> venues;
              if (positionProvider.positionKnown) {
                final double lat = positionProvider.latitude;
                final double long = positionProvider.longitude;
                weatherChecker.updateLocation(lat, long);
                venues = widget.venues.nearestTo(latitude: lat, longitude: long);
              } else {
                venues = widget.venues.all;
              }

              return Stack(
                children: [
                  // Next card (but hidden)
                  if (counter + 1 < venues.length)
                    Dismissible(
                      key: Key(venues[counter + 1].name), // Key for the next card
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        counter++;
                        if (direction == DismissDirection.endToStart) {
                          cart.add(venues[counter]);
                        }
                      },
                      child: CardView(venues[counter + 1]),
                    ),
                  // Current card
                  Dismissible(
                    key: Key(venues[counter].name), // Key for the current card
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        cart.add(venues[counter]);
                      }
                      setState(() {
                        counter == venues.length - 1 ? counter = 0 : counter++;
                      });
                    },
                    child: CardView(venues[counter]),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Semantics(
                      label: 'clicking view cart navigates to new panel with all saved swipes',
                      child: GestureDetector( // for the cart button
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartView(
                                weatherProvider.condition,
                                cart,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0, bottom: 5.0),
                          child: Semantics(label: 'view cart button', child: const Icon(
                            IconData(0xe59c, fontFamily: 'MaterialIcons'), // cart icon
                            size: 60,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
