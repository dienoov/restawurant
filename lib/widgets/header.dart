import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            'Rstwrnt',
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w900),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          IconButton(
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.bookmark_outline),
            iconSize: 24,
            onPressed: () {
              Navigator.pushNamed(context, '/bookmarks');
            },
          ),
          SizedBox(width: 8),
          IconButton(
            color: Theme.of(context).colorScheme.onSurface,
            icon: const Icon(Icons.settings),
            iconSize: 24,
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
