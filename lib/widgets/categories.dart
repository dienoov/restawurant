import 'package:flutter/material.dart';
import 'package:restawurant/models/restaurant.dart';

class Categories extends StatelessWidget {
  final Restaurant restaurant;

  const Categories({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(restaurant.categories!.length, (index) {
        final Category? category = restaurant.categories?[index];
        return Chip(
          label: Text(category!.name),
          backgroundColor: Theme.of(context).colorScheme.surface,
          labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.onSurface,
            width: 1,
          ),
        );
      }),
    );
  }
}
