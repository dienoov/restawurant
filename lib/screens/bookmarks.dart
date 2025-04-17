import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/providers/bookmarks.dart';
import 'package:restawurant/widgets/restaurant_card.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  void initState() {
    Future.microtask(() {
      if (mounted) {
        Provider.of<BookmarksProvider>(context, listen: false).list();
      }
    });
    super.initState();
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
                    key: ValueKey('backButton'),
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Bookmarks',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Consumer<BookmarksProvider>(
                builder: (context, value, child) {
                  return switch (value.bookmarks.isEmpty) {
                    true => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.collections_bookmark_outlined,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox.square(dimension: 16),
                          Text(
                            'No bookmarks yet',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    false => ListView.builder(
                      key: ValueKey('bookmarkList'),
                      itemCount: value.bookmarks.length,
                      itemBuilder: (context, index) {
                        final restaurant = value.bookmarks[index];
                        return RestaurantCard(restaurant: restaurant);
                      },
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
