import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restawurant/providers/notifications.dart';
import 'package:restawurant/providers/theme.dart';
import 'package:restawurant/services/notifications.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> onChanged() async {
    final NotificationsProvider notificationsProvider =
        Provider.of<NotificationsProvider>(context, listen: false);

    final bool isGranted =
        await NotificationsService().requestPermissions() ?? false;

    if (isGranted) {
      notificationsProvider.toggle();
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.onError,
          content: Text(
            'Notifications permission denied',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
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
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Dark Mode',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: Switch(
                value:
                    Provider.of<ThemeProvider>(context).themeMode ==
                    ThemeMode.dark,
                onChanged: (value) {
                  Provider.of<ThemeProvider>(context, listen: false).toggle();
                },
              ),
            ),
            ListTile(
              title: Text(
                'Daily Notifications',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              trailing: Switch(
                value: Provider.of<NotificationsProvider>(context).isEnabled,
                onChanged: (value) async {
                  await onChanged();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
