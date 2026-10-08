import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/features/history/presentation/history_page.dart';
import 'package:garir_khata/features/home/presentation/home_page.dart';
import 'package:garir_khata/features/more/presentation/more_page.dart';
import 'package:garir_khata/features/reports/presentation/reports_page.dart';
import 'package:garir_khata/features/shell/presentation/main_shell.dart';
import 'package:garir_khata/features/shell/presentation/route_not_found_page.dart';
import 'package:garir_khata/features/vehicles/presentation/vehicles_page.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    debugLogDiagnostics: false,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                name: 'history',
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reports',
                name: 'reports',
                builder: (context, state) => const ReportsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                name: 'more',
                builder: (context, state) => const MorePage(),
                routes: [
                  GoRoute(
                    path: 'vehicles',
                    name: 'vehicles',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const VehiclesPage(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Absolute deep link friendly alias used by More page.
      GoRoute(
        path: '/vehicles',
        redirect: (context, state) => '/more/vehicles',
      ),
    ],
    errorBuilder: (context, state) => const RouteNotFoundPage(),
  );
});
