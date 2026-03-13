import 'package:flutter/material.dart';
import '../widgets/food_image_widget.dart';

// Reusable FoodDetailScreen
class FoodDetailScreen extends StatefulWidget {
  final String imagePath;
  final String foodName;
  final String description;
  final double rating;
  final String
  deliveryTime; // Estimated total delivery time (preparing food + delivery)
  final double unitPrice;

  const FoodDetailScreen({
    Key? key,
    required this.imagePath,
    required this.foodName,
    required this.description,
    required this.rating,
    required this.deliveryTime,
    required this.unitPrice,
  }) : super(key: key);

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int portion = 1;
  double spicyLevel = 0.7;

  void _placeOrder() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ Order placed'), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                          Icon(Icons.search, color: Colors.black),
                        ],
                      ),
                    ),

                    // Food Image
                    Center(
                      child: buildFoodImage(
                        imagePath: widget.imagePath,
                        height: 290,
                      ),
                    ),

                    SizedBox(height: 16),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Food Name
                          Text(
                            widget.foodName,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          SizedBox(height: 6),

                          // Rating & Delivery Time
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.orange, size: 18),
                              SizedBox(width: 4),
                              Text(
                                '${widget.rating}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '  —  ${widget.deliveryTime}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12),

                          // Description
                          Text(
                            widget.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),

                          SizedBox(height: 24),

                          // Spicy & Portion Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Spicy Slider
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    Text(
                                      'Spicy',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),

                                    SizedBox(height: 8),

                                    // Slider shifted left to align with title
                                    Transform.translate(
                                      offset: Offset(-23, 0),
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackShape: ShadowedTrackShape(),
                                          overlayColor: Colors.red.withValues(
                                            alpha: 0.2,
                                          ),
                                          trackHeight: 4,
                                          thumbShape: PillThumbShape(
                                            width: 12,
                                            height: 16,
                                          ),
                                        ),
                                        child: Slider(
                                          value: spicyLevel,
                                          min: 0.0,
                                          max: 1.0,
                                          onChanged: (value) {
                                            setState(() => spicyLevel = value);
                                          },
                                        ),
                                      ),
                                    ),

                                    // Mild & Hot labels, same shift as slider (correct positions in any screen size)
                                    SizedBox(
                                      width: double.infinity,
                                      child: Stack(
                                        children: [
                                          // Invisible placeholder to give Stack a height
                                          SizedBox(height: 20),
                                          // Mild label, left edge
                                          Positioned(
                                            left: 0,
                                            child: Text(
                                              'Mild',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.green,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),

                                          // Hot label, right edge
                                          Positioned(
                                            right: 45,
                                            child: Text(
                                              'Hot',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 20),

                              // Portion Counter
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    'Portion',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  Row(
                                    children: [
                                      // Minus button
                                      GestureDetector(
                                        onTap: () {
                                          // Minimum portion = 1
                                          if (portion > 1) {
                                            setState(() => portion--);
                                          }
                                        },
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.orange.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 6,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      // Portion number
                                      Text(
                                        '$portion',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      SizedBox(width: 12),

                                      // Plus button
                                      GestureDetector(
                                        onTap: () => setState(() => portion++),
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.orange.withValues(
                                                  alpha: 0.3,
                                                ),
                                                blurRadius: 6,
                                                offset: Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  // Price (portion * unitPrice)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      '\$${(portion * widget.unitPrice).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  // Order Now Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _placeOrder();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 6,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'ORDER NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom pill-shaped thumb
class PillThumbShape extends SliderComponentShape {
  final double width;
  final double height;

  const PillThumbShape({this.width = 12, this.height = 16});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, height);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // Shadow (must be drawn before fill)
    final shadowPaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center, // no translation, centered on all sides
        width: width + 6, // slightly larger to spread shadow equally
        height: height + 6,
      ),
      Radius.circular(5),
    );

    // Red fill
    final fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // White border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      Radius.circular(5),
    );

    canvas.drawRRect(shadowRect, shadowPaint); // draw shadow first
    canvas.drawRRect(rect, fillPaint); // then fill
    canvas.drawRRect(rect, borderPaint); // border on top
  }
}

// Custom track shape with shadow only on active part
class ShadowedTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final canvas = context.canvas;
    final trackHeight = sliderTheme.trackHeight ?? 4;
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    // Active part (left side — up to thumb)
    final activeRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        trackRect.left,
        trackRect.top,
        thumbCenter.dx,
        trackRect.bottom,
      ),
      Radius.circular(trackHeight / 2),
    );

    // Inactive part (right side — from thumb to end)
    final inactiveRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        thumbCenter.dx,
        trackRect.top,
        trackRect.right,
        trackRect.bottom,
      ),
      Radius.circular(trackHeight / 2),
    );

    // Active shadow
    final shadowPaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.34)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final shadowRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        trackRect.left,
        trackRect.top - 2,
        thumbCenter.dx,
        trackRect.bottom + 2,
      ),
      Radius.circular(trackHeight / 2),
    );

    // Draw inactive track
    canvas.drawRRect(
      inactiveRect,
      Paint()..color = Colors.green[200]!,
    ); // since "Mild" text color is Green

    // Draw active shadow (before fill)
    canvas.drawRRect(shadowRect, shadowPaint);

    // Draw active track
    canvas.drawRRect(activeRect, Paint()..color = Colors.red);
  }
}
