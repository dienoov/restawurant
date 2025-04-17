import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/models/restaurant.dart';
import 'package:restawurant/providers/bookmarks.dart';

class BookmarkButton extends StatefulWidget {
  final Restaurant restaurant;

  const BookmarkButton({super.key, required this.restaurant});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (mounted) {
        Provider.of<BookmarksProvider>(
          context,
          listen: false,
        ).detail(widget.restaurant.id);
      }
    });
  }

  void onPressed() {
    final provider = Provider.of<BookmarksProvider>(context, listen: false);

    if (provider.isBookmarked(widget.restaurant)) {
      provider.remove(widget.restaurant);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onError,
          content: Text(
            '${widget.restaurant.name} removed from bookmarks',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      provider.add(widget.restaurant);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            '${widget.restaurant.name} added to bookmarks',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    provider.detail(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarksProvider>(
      builder: (context, value, child) {
        return IconButton(
          key: ValueKey('bookmarkButton'),
          icon: Icon(
            Provider.of<BookmarksProvider>(
                  context,
                ).isBookmarked(widget.restaurant)
                ? Icons.bookmark_remove_outlined
                : Icons.bookmark_add_outlined,
          ),
          iconSize: 24,
          onPressed: onPressed,
        );
      },
    );
  }
}
