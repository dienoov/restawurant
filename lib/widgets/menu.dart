import 'package:flutter/material.dart';

import '../models/restaurant.dart';

enum MenuType { foods, drinks }

class Menu extends StatelessWidget {
  final List<Category> menu;
  final MenuType menuType;

  const Menu({super.key, required this.menu, required this.menuType});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color:
              menuType == MenuType.foods
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menuType == MenuType.foods ? 'Foods' : 'Drinks',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color:
                    menuType == MenuType.foods
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onSecondary,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox.square(dimension: 16),
            ...menu.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  item.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color:
                        menuType == MenuType.foods
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
