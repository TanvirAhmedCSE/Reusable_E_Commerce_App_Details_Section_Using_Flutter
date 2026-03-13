import 'package:flutter/material.dart';
import 'food_detail_screen.dart';
import '../widgets/food_image_widget.dart';

// Food data Model
class FoodItem {
  final String imagePath;
  final String foodName;
  final String description;
  final double rating;
  final String deliveryTime;
  final double unitPrice;

  FoodItem({
    required this.imagePath,
    required this.foodName,
    required this.description,
    required this.rating,
    required this.deliveryTime,
    required this.unitPrice,
  });
}

class FoodGridScreen extends StatelessWidget {
  // Food data
  final List<FoodItem> foods = [
    FoodItem(
      //imagePath: 'images/margherita_pizza.png',
      imagePath:
          'https://image2url.com/r2/default/images/1773328919060-e5ad560d-22f7-4e11-825d-a1953de3566e.png',
      foodName: 'Margherita Pizza',
      description:
          'Experience the timeless taste of Italy with our Margherita Pizza, crafted on a golden, hand-tossed crust and smothered in rich tomato sauce, creamy fresh mozzarella.',
      rating: 4.5,
      deliveryTime: '20 mins',
      unitPrice: 12.99,
    ),
    FoodItem(
      //imagePath: 'images/burger.png',
      imagePath:
          'https://image2url.com/r2/default/images/1773328210169-7d7e0d51-1bf3-48e6-80d9-44a3f20cf573.png',
      foodName: 'Hamburger Veggie Burger',
      description:
          'Enjoy our delicious Hamburger Veggie Burger, made with a savory blend of fresh vegetables and herbs, topped with crisp lettuce, juicy tomatoes, and tangy pickles, all served on a soft, toasted bun.',
      rating: 4.8,
      deliveryTime: '14 mins',
      unitPrice: 9.99,
    ),
    FoodItem(
      //imagePath: 'images/ramen_bowl.png',
      imagePath:
          'https://image2url.com/r2/default/images/1773392513613-69772a47-8389-4775-aac4-0d68bfca58fa.png',
      foodName: 'Ramen Bowl',
      description:
          'Warm your soul with our signature Ramen Bowl, featuring a deep, slow-cooked tonkotsu broth loaded with silky soft noodles.',
      rating: 4.8,
      deliveryTime: '25 mins',
      unitPrice: 14.99,
    ),
    FoodItem(
      //imagePath: 'images/tacos.png',
      imagePath:
          'https://image2url.com/r2/default/images/1773393307426-df09b58b-46dd-458b-9509-7a08bbfd0beb.png',
      foodName: 'Tacos',
      description:
          'Savor the bold flavors of our classic Tacos, packed with perfectly seasoned grilled meat, melted cheddar cheese, crisp shredded lettuce, and zesty fresh salsa.',
      rating: 4.6,
      deliveryTime: '12 mins',
      unitPrice: 8.49,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Popular Foods',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: foods.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            //childAspectRatio: 0.78, // card height/width ratio, have to adjust it
            mainAxisExtent: 254,
          ),
          itemBuilder: (context, index) {
            FoodItem food = foods[index];

            return GestureDetector(
              onTap: () {
                // Go to FoodDetailScreen by passing food data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(
                      imagePath: food.imagePath,
                      foodName: food.foodName,
                      description: food.description,
                      rating: food.rating,
                      deliveryTime: food.deliveryTime,
                      unitPrice: food.unitPrice,
                    ),
                  ),
                );
              },
              child: _buildFoodCard(food),
            );
          },
        ),
      ),
    );
  }

  // Food Card UI
  Widget _buildFoodCard(FoodItem food) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade500),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            child: buildFoodImage(
              imagePath: food.imagePath,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),

          // Food Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Food Name
                Text(
                  food.foodName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 6),

                // Rating & Delivery Time
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 14),
                    SizedBox(width: 3),
                    Text(
                      '${food.rating}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.access_time, color: Colors.grey, size: 14),
                    SizedBox(width: 3),
                    Text(
                      food.deliveryTime,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Price
                Text(
                  '\$${food.unitPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
