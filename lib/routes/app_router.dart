import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/shell/main_shell_page.dart';
import '../features/home/home_page.dart';
import '../features/network_example/network_page.dart';
import '../features/storage_example/storage_page.dart';
import '../features/settings/settings_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShellPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/network',
          builder: (context, state) => const NetworkPage(),
        ),
        GoRoute(
          path: '/storage',
          builder: (context, state) => const StoragePage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
