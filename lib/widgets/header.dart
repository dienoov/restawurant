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
            icon: const Icon(Icons.search),
            iconSize: 24,
            onPressed: () {},
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              color: Theme.of(context).colorScheme.surface,
              icon: const Icon(Icons.bookmark_outline),
              iconSize: 24,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
