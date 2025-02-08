import 'package:flutter/material.dart';
import 'package:food_finder/weather_conditions.dart';

import '../models/venue.dart';

// This class is the main display that includes the list of all items the user has swiped right on.
// It includes Semantics too, and the font is large to accommodate accessibility
class CartView extends StatelessWidget {
  final WeatherCondition cond;
  final List<Venue> cart;
  const CartView(this.cond, this.cart, {super.key});

  /// Builds the widget to display the restaurants that the user likes/ has saved
  /// Includes details on which places contain patios
  /// Parameters:
  ///   - The Build context of the widget tree
  /// Returns: a Semantics widget containing a List of items.
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Added Scaffold here
      appBar: AppBar(
        title: Semantics(
          label: 'Your Swipe Summary',
          child: const Text('Your Swipe Summary')
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_backgroundColorForCondition(cond)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                child: Semantics(
                  label: 'It is currently ${_textForCondition(cond)}',
                  child: Text(
                    _textForCondition(cond),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
              const Divider(
                color: Colors.black,
                thickness: 2.0,
                height: 10.0,
              ),
              Expanded(
                child: ListView.builder( // the list of all venues the user saved
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final venue = cart[index];
                    return ListTile(
                      title: Semantics(
                        label: venue.name,
                        child: Text(
                          venue.name,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      trailing: venue.hasPatio
                          ? Semantics(label: 'has Patio', child: const Icon(IconData(0xe463, fontFamily: 'MaterialIcons')))
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// This is a helper function to display the background image based on the weather
  /// Parameters:
  ///   - The weather condition
  /// Returns:
  ///   - Rainy image URL if it is rainy, sunny image URL if it is is sunny, gloomy URL if gloomy and blank/ empty for unknown.
  String _backgroundColorForCondition(WeatherCondition condition){
    return switch(condition) {
      WeatherCondition.rainy => 'https://media.istockphoto.com/id/1277561237/vector/cartoon-raining-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=LRLddc_LhV0r8jIfn5DGu2yy_ii8cN-K9vH_aa0PHW4=',
      WeatherCondition.sunny => 'https://static.vecteezy.com/system/resources/previews/029/131/015/non_2x/bright-sunny-yellow-dynamic-abstract-background-lemon-orange-color-ai-generative-free-photo.jpg',
      WeatherCondition.gloomy => 'https://www.shutterstock.com/image-vector/dramatic-autumn-sky-stormy-clouds-600nw-2374757681.jpg',
      WeatherCondition.unknown => 'https://wallcoveringsmart.com/cdn/shop/files/TS81900.jpg?v=1694208042',
    };
  }

  /// This is a helper function to display the supporting text based on the weather
  /// Parameters:
  ///   - The weather condition
  /// Returns:
  ///   - An appropriate text for the weather. Also, if it is sunny includes a reminder to look for Patios.
  String _textForCondition(WeatherCondition condition){
    return switch(condition) {
      WeatherCondition.rainy => 'Oh no its raining :/',
      WeatherCondition.sunny => 'Its sunny! Lookout for restaurants with patios!',
      WeatherCondition.gloomy => 'Its a gloomy day huh D:',
      WeatherCondition.unknown => 'Your selections:',
    };
  }
}