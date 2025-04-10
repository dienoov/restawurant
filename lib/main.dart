import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/providers/restaurant.dart';
import 'package:restawurant/providers/restaurants.dart';
import 'package:restawurant/screens/home.dart';
import 'package:restawurant/screens/restaurant.dart';
import 'package:restawurant/styles/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(RestaurantsApi()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(RestaurantsApi()),
        ),
      ],
      child: const Restawurant(),
    ),
  );
}

class Restawurant extends StatelessWidget {
  const Restawurant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restawurant',
      theme: RestawurantThemeData.lightTheme,
      darkTheme: RestawurantThemeData.darkTheme,
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const HomeScreen(),
        '/restaurant':
            (context) => RestaurantScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
