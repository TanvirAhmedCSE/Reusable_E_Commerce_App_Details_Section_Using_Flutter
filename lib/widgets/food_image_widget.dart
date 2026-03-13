import 'package:flutter/material.dart';

// Reusable widget. It supports both asset images and network images.
Widget buildFoodImage({
  required String imagePath,
  required double height,
  BoxFit fit = BoxFit.contain,
}) {
  // Check if the path is a URL
  bool isNetwork =
      imagePath.startsWith('http://') || imagePath.startsWith('https://');

  if (isNetwork) {
    return Image.network(
      imagePath,
      height: height,
      width: double.infinity,
      fit: fit,
      // Shows loading indicator while image is fetching
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          child: Center(
            child: CircularProgressIndicator(color: Colors.red, strokeWidth: 2),
          ),
        );
      },
      // Shows fallback icon if image fails to load
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: height,
          color: Colors.grey[100],
          child: Icon(Icons.fastfood, size: 60, color: Colors.grey),
        );
      },
    );
  } else {
    // Load image from local assets
    return Image.asset(
      imagePath,
      height: height,
      width: double.infinity,
      fit: fit,
    );
  }
}
