import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/providers/restaurants.dart';
import 'package:restawurant/providers/state.dart';
import 'package:restawurant/widgets/error_message.dart';
import 'package:restawurant/widgets/header.dart';
import 'package:restawurant/widgets/loading.dart';
import 'package:restawurant/widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        Provider.of<RestaurantsProvider>(context, listen: false).list();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            Expanded(
              child: Consumer<RestaurantsProvider>(
                builder: (context, value, child) {
                  return switch (value.state) {
                    LoadingState() => Loading(),
                    ErrorState(error: String message) => ErrorMessage(
                      message: message,
                    ),
                    LoadedState(data: List<Restaurant> restaurants) =>
                      ListView.builder(
                        itemCount: restaurants.length,
                        itemBuilder: (context, index) {
                          final restaurant = restaurants[index];
                          return RestaurantCard(restaurant: restaurant);
                        },
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: ValueKey('searchButton'),
          onPressed: () {
            Navigator.pushNamed(context, '/search');
          },
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
