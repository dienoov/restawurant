import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/providers/search.dart';
import 'package:restawurant/providers/state.dart';
import 'package:restawurant/widgets/error_message.dart';
import 'package:restawurant/widgets/loading.dart';
import 'package:restawurant/widgets/restaurant_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchProvider>(context, listen: false).reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  // search text field
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onSubmitted: (String value) {
                        if (value.isNotEmpty) {
                          Provider.of<SearchProvider>(
                            context,
                            listen: false,
                          ).search(value);
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Search restaurant',
                        hintStyle: Theme.of(
                          context,
                        ).textTheme.headlineMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withAlpha(150),
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                      ),
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<SearchProvider>(
                builder: (context, value, child) {
                  return switch (value.state) {
                    LoadingState() => Loading(),
                    ErrorState(error: String message) => ErrorMessage(
                      message: message,
                    ),
                    LoadedState(data: List<Restaurant> restaurants) =>
                      restaurants.isNotEmpty
                          ? ListView.builder(
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              return RestaurantCard(restaurant: restaurant);
                            },
                          )
                          : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 64,
                                  color: Theme.of(context).colorScheme.error,
                                ),
                                const SizedBox.square(dimension: 16),
                                Text(
                                  'Restaurant not found',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                    _ => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox.square(dimension: 16),
                          Text(
                            'Search for restaurant',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
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
