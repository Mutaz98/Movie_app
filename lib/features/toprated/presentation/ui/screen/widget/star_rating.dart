import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating; // Rating value between 0 to 10
  final int starCount; // Number of stars (e.g., 5)

  StarRating({required this.rating, this.starCount = 5});

  @override
  Widget build(BuildContext context) {
    int fullStars =
        (rating / 2).floor(); // Get full stars (rating / 2, because max is 10)
    double fractionalStar = (rating / 2) - fullStars;
    return Row(
      children: List.generate(starCount, (index) {
        if (index < fullStars) {
          return const Icon(
            Icons.star,
            color: Colors.orange,
            size: 20,
          );
        } else if (index < fullStars + 1 && fractionalStar > 0) {
          return const Icon(
            Icons.star_half,
            color: Colors.orange,
            size: 20,
          );
        } else {
          return const Icon(
            Icons.star_border,
            color: Colors.orange,
            size: 20,
          );
        }
      }),
    );
  }
}
