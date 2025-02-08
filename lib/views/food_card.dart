import 'package:flutter/material.dart';
import '../models/venue.dart';

// This class is the display for an individual card for the user to swipe on.
// It includes Semantics too, and the font is large to accommodate accessibility
class CardView extends StatelessWidget {
  final Venue restaurant;
  const CardView(this.restaurant, {super.key});

  /// This is a helper function to take a nullable string for the image URL.
  /// If it is null, then we set a default image.
  /// Returns:
  ///   - a String URL for the display image
  String getImageURL() {
    final String? img = restaurant.image;
    if (img != null) {
      return img;
    } else {
      return 'https://eagle-sensors.com/wp-content/uploads/unavailable-image.jpg';
    }
  }

  /// Builds the widget to display the individual card.
  /// Parameters:
  ///   - The Build context of the widget tree
  /// Returns: a Semantics widget containing a Text with the temp and a label.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(getImageURL()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Overlay Text
        // Overlay to improve contrast
        Opacity(
          opacity: 0.5, // 50% opacity
          child: Container(
            color: Colors.black, // Fully opaque black color
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Semantics(
                label: restaurant.name,
                child: Text(restaurant.name, style: const TextStyle( // main restaurant name
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ))
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 16.0),
              child: Semantics(
                label: '${restaurant.cuisine} cuisine food',
                child: Text('${restaurant.cuisine} Cuisine', style: const TextStyle( // cuisine
                  fontSize: 25,
                  color: Colors.white,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Semantics(
                label: 'Rated ${restaurant.rating} out of 5',
                child: Text('Rated ${restaurant.rating} / 5', style: const TextStyle( // ratings from the JSON
                  fontSize: 25,
                  color: Colors.white,
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }

}