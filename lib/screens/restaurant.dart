import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/providers/restaurant.dart';
import 'package:restawurant/providers/state.dart';
import 'package:restawurant/widgets/bookmark_button.dart';
import 'package:restawurant/widgets/categories.dart';
import 'package:restawurant/widgets/error_message.dart';
import 'package:restawurant/widgets/loading.dart';
import 'package:restawurant/widgets/menu.dart';
import 'package:restawurant/widgets/rating.dart';
import 'package:restawurant/widgets/reviews.dart';

class RestaurantScreen extends StatefulWidget {
  final String id;

  const RestaurantScreen({super.key, required this.id});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        Provider.of<RestaurantProvider>(
          context,
          listen: false,
        ).detail(widget.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    key: ValueKey('backButton'),
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Consumer<RestaurantProvider>(
                    builder: (context, value, child) {
                      return switch (value.state) {
                        LoadedState(data: Restaurant restaurant) =>
                          BookmarkButton(restaurant: restaurant),
                        _ => const SizedBox(),
                      };
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<RestaurantProvider>(
                builder: (context, value, child) {
                  return switch (value.state) {
                    LoadingState() => Loading(),
                    ErrorState(error: String message) => ErrorMessage(
                      message: message,
                    ),
                    LoadedState(data: Restaurant restaurant) =>
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                              tag: restaurant.id,
                              child: ConstrainedBox(
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
                            ),
                            const SizedBox.square(dimension: 12),
                            Hero(
                              tag: restaurant.name,
                              child: Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.displayMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                            ),
                            const SizedBox.square(dimension: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        restaurant.city,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                      SizedBox.square(dimension: 2),
                                      Text(
                                        restaurant.address ?? '',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelSmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Rating(rating: restaurant.rating),
                              ],
                            ),
                            const SizedBox.square(dimension: 16),
                            Text(restaurant.description),
                            const SizedBox.square(dimension: 24),
                            Categories(restaurant: restaurant),
                            const SizedBox.square(dimension: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MenuCard(
                                  menu: restaurant.menus!.foods,
                                  menuType: MenuType.foods,
                                ),
                                const SizedBox.square(dimension: 16),
                                MenuCard(
                                  menu: restaurant.menus!.drinks,
                                  menuType: MenuType.drinks,
                                ),
                              ],
                            ),
                            const SizedBox.square(dimension: 24),
                            Reviews(
                              id: restaurant.id,
                              customerReviews: restaurant.customerReviews!,
                              onSubmit: () {
                                Provider.of<RestaurantProvider>(
                                  context,
                                  listen: false,
                                ).detail(restaurant.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
