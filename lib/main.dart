import 'package:flutter/material.dart';
import 'food_detail_screen.dart';
import 'food_grid_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Uncomment it, if you want to see only a Food Details Screen (i.e. Hamburger Veggie Burger Screen or any other)
      // home: FoodDetailScreen(
      // // It supports both network images and asset images
      //   //imagePath: 'images/burger.png',
      //   imagePath:
      //       'https://image2url.com/r2/default/images/1773328210169-7d7e0d51-1bf3-48e6-80d9-44a3f20cf573.png',
      //   foodName: 'Hamburger Veggie Burger',
      //   description:
      //       'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
      //   rating: 4.8,
      //   deliveryTime: '14 mins',
      //   unitPrice: 9.99,
      // ),

      // To see the Reusability of Food Details Screen (E-Commerce App Details Screen)
      home: FoodGridScreen(),
    );
  }
}
