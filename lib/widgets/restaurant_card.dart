import 'package:flutter/material.dart';
import 'package:restawurant/models/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 240,
                  maxHeight: 240,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox.square(dimension: 12),
              Text(
                restaurant.name,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              const SizedBox.square(dimension: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      restaurant.city,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    children: List.generate(
                      restaurant.rating.toInt(),
                      (index) => Transform.translate(
                        offset: Offset(
                          (restaurant.rating.toInt() - index - 1) * 6,
                          0,
                        ),
                        child: Icon(
                          Icons.circle,
                          color: Theme.of(context).colorScheme.primary,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox.square(dimension: 6),
                  Text(
                    restaurant.rating.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox.square(dimension: 4),
                ],
              ),
              const SizedBox.square(dimension: 6),
            ],
          ),
        ),
      ),
    );
  }
}
