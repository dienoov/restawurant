import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          rating.toInt(),
          (index) => Transform.translate(
            offset: Offset((rating.toInt() - index - 1) * 6, 0),
            child: Icon(
              Icons.circle,
              color: Theme.of(context).colorScheme.primary,
              size: 14,
            ),
          ),
        ),
        const SizedBox.square(dimension: 6),
        Text(
          rating.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox.square(dimension: 4),
      ],
    );
  }
}
