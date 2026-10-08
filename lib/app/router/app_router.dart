import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/features/expenses/presentation/add_edit_expense_page.dart';
import 'package:garir_khata/features/expenses/presentation/expense_details_page.dart';
import 'package:garir_khata/features/expenses/presentation/expense_history_page.dart';
import 'package:garir_khata/features/fuel/presentation/add_edit_fuel_page.dart';
import 'package:garir_khata/features/fuel/presentation/fuel_details_page.dart';
import 'package:garir_khata/features/fuel/presentation/fuel_history_page.dart';
import 'package:garir_khata/features/history/presentation/history_page.dart';
import 'package:garir_khata/features/home/presentation/home_page.dart';
import 'package:garir_khata/features/maintenance/presentation/add_edit_service_page.dart';
import 'package:garir_khata/features/maintenance/presentation/add_oil_change_page.dart';
import 'package:garir_khata/features/maintenance/presentation/oil_details_page.dart';
import 'package:garir_khata/features/maintenance/presentation/oil_history_page.dart';
import 'package:garir_khata/features/maintenance/presentation/service_details_page.dart';
import 'package:garir_khata/features/maintenance/presentation/service_history_page.dart';
import 'package:garir_khata/features/more/presentation/more_page.dart';
import 'package:garir_khata/features/odometer/presentation/odometer_history_page.dart';
import 'package:garir_khata/features/odometer/presentation/update_odometer_page.dart';
import 'package:garir_khata/features/onboarding/presentation/language_page.dart';
import 'package:garir_khata/features/onboarding/presentation/odometer_page.dart';
import 'package:garir_khata/features/onboarding/presentation/setup_complete_page.dart';
import 'package:garir_khata/features/onboarding/presentation/splash_page.dart';
import 'package:garir_khata/features/onboarding/presentation/vehicle_details_page.dart';
import 'package:garir_khata/features/onboarding/presentation/vehicle_type_page.dart';
import 'package:garir_khata/features/onboarding/presentation/welcome_page.dart';
import 'package:garir_khata/features/reports/presentation/reports_page.dart';
import 'package:garir_khata/features/settings/application/settings_controller.dart';
import 'package:garir_khata/features/shell/presentation/main_shell.dart';
import 'package:garir_khata/features/shell/presentation/route_not_found_page.dart';
import 'package:garir_khata/features/vehicles/presentation/vehicle_form_page.dart';
import 'package:garir_khata/features/vehicles/presentation/vehicle_profile_page.dart';
import 'package:garir_khata/features/vehicles/presentation/vehicles_page.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final settings = ref.read(settingsControllerProvider);
      final String path = state.uri.path;
      final bool onboardingRoute =
          path.startsWith('/onboarding') || path == '/splash';
      final bool completed = settings.onboardingCompleted;

      if (!completed && !onboardingRoute) {
        return '/splash';
      }
      if (completed &&
          onboardingRoute &&
          path != '/onboarding/complete' &&
          path != '/splash') {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding/language',
        name: 'onboardingLanguage',
        builder: (context, state) => const LanguagePage(),
      ),
      GoRoute(
        path: '/onboarding/welcome',
        name: 'onboardingWelcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/onboarding/vehicle-type',
        name: 'onboardingVehicleType',
        builder: (context, state) => const VehicleTypePage(),
      ),
      GoRoute(
        path: '/onboarding/vehicle-details',
        name: 'onboardingVehicleDetails',
        builder: (context, state) => const VehicleDetailsPage(),
      ),
      GoRoute(
        path: '/onboarding/odometer',
        name: 'onboardingOdometer',
        builder: (context, state) => const OdometerPage(),
      ),
      GoRoute(
        path: '/onboarding/complete',
        name: 'onboardingComplete',
        builder: (context, state) => const SetupCompletePage(),
      ),
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
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/vehicles',
        name: 'vehicles',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const VehiclesPage(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'vehicleAdd',
            builder: (context, state) => const VehicleFormPage(),
          ),
          GoRoute(
            path: ':id',
            name: 'vehicleProfile',
            builder: (context, state) =>
                VehicleProfilePage(vehicleId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'vehicleEdit',
                builder: (context, state) =>
                    VehicleFormPage(vehicleId: state.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/fuel',
        name: 'fuelHistory',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FuelHistoryPage(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'fuelAdd',
            builder: (context, state) => const AddEditFuelPage(),
          ),
          GoRoute(
            path: ':id',
            name: 'fuelDetails',
            builder: (context, state) =>
                FuelDetailsPage(fuelId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'fuelEdit',
                builder: (context, state) =>
                    AddEditFuelPage(fuelId: state.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/odometer/update',
        name: 'odometerUpdate',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const UpdateOdometerPage(),
      ),
      GoRoute(
        path: '/odometer/history',
        name: 'odometerHistory',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OdometerHistoryPage(),
      ),
      GoRoute(
        path: '/expenses',
        name: 'expenseHistory',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ExpenseHistoryPage(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'expenseAdd',
            builder: (context, state) => AddEditExpensePage(
              initialCategoryCode: state.uri.queryParameters['category'],
            ),
          ),
          GoRoute(
            path: ':id',
            name: 'expenseDetails',
            builder: (context, state) =>
                ExpenseDetailsPage(expenseId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'expenseEdit',
                builder: (context, state) =>
                    AddEditExpensePage(expenseId: state.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/services',
        name: 'serviceHistory',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ServiceHistoryPage(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'serviceAdd',
            builder: (context, state) => const AddEditServicePage(),
          ),
          GoRoute(
            path: ':id',
            name: 'serviceDetails',
            builder: (context, state) =>
                ServiceDetailsPage(serviceId: state.pathParameters['id']!),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'serviceEdit',
                builder: (context, state) =>
                    AddEditServicePage(serviceId: state.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/oil',
        name: 'oilHistory',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OilHistoryPage(),
        routes: [
          GoRoute(
            path: 'add',
            name: 'oilAdd',
            builder: (context, state) => const AddOilChangePage(),
          ),
          GoRoute(
            path: ':id',
            name: 'oilDetails',
            builder: (context, state) =>
                OilDetailsPage(oilId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const RouteNotFoundPage(),
  );

  ref.listen(settingsControllerProvider, (_, _) {
    router.refresh();
  });
  ref.onDispose(router.dispose);

  return router;
});
