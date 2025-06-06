import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/databases/bookmark.dart';
import 'package:restawurant/providers/bookmarks.dart';
import 'package:restawurant/providers/notifications.dart';
import 'package:restawurant/providers/restaurant.dart';
import 'package:restawurant/providers/restaurants.dart';
import 'package:restawurant/providers/search.dart';
import 'package:restawurant/providers/theme.dart';
import 'package:restawurant/screens/bookmarks.dart';
import 'package:restawurant/screens/home.dart';
import 'package:restawurant/screens/restaurant.dart';
import 'package:restawurant/screens/search.dart';
import 'package:restawurant/screens/settings.dart';
import 'package:restawurant/services/notifications.dart';
import 'package:restawurant/services/workmanager.dart';
import 'package:restawurant/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WorkmanagerService().init();
  await NotificationsService().init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RestaurantsProvider(RestaurantsApi()),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantProvider(RestaurantsApi()),
        ),
        ChangeNotifierProvider(
          create: (context) => BookmarksProvider(BookmarkDatabase()),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(RestaurantsApi()),
        ),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
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
      debugShowCheckedModeBanner: false,
      title: 'Restawurant',
      theme: RestawurantThemeData.lightTheme,
      darkTheme: RestawurantThemeData.darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      routes: {
        '/': (context) => const HomeScreen(),
        '/restaurant':
            (context) => RestaurantScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        '/bookmarks': (context) => const BookmarksScreen(),
        '/search': (context) => const SearchScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
