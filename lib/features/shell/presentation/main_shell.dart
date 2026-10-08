import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:garir_khata/app/localization/l10n_extension.dart';
import 'package:garir_khata/app/theme/app_colors.dart';
import 'package:garir_khata/app/theme/app_spacing.dart';
import 'package:go_router/go_router.dart';

class MainShell extends ConsumerWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  int get _navIndex {
    final int branch = navigationShell.currentIndex;
    // Branches: 0 Home, 1 History, 2 Reports, 3 More
    // Nav:      0 Home, 1 History, 2 Add, 3 Reports, 4 More
    if (branch <= 1) {
      return branch;
    }
    return branch + 1;
  }

  void _onBranchSelected(int branchIndex) {
    navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == navigationShell.currentIndex,
    );
  }

  Future<void> _openQuickAdd(BuildContext context) async {
    final l10n = context.l10n;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.addSheetTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                ListTile(
                  leading: const Icon(Icons.local_gas_station_outlined),
                  title: Text(l10n.addFuel),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push('/fuel/add');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.payments_outlined),
                  title: Text(l10n.addExpense),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push('/expenses/add');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.build_outlined),
                  title: Text(l10n.addService),
                  onTap: () => Navigator.of(context).pop(),
                ),
                ListTile(
                  leading: const Icon(Icons.settings_suggest_outlined),
                  title: Text(l10n.addRepair),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push('/expenses/add?category=repair');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.speed_outlined),
                  title: Text(l10n.updateOdometer),
                  onTap: () {
                    Navigator.of(context).pop();
                    context.push('/odometer/update');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.description_outlined),
                  title: Text(l10n.addDocument),
                  onTap: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (selected) {
          if (selected == 2) {
            _openQuickAdd(context);
            return;
          }
          if (selected < 2) {
            _onBranchSelected(selected);
          } else {
            _onBranchSelected(selected - 1);
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.history_outlined),
            selectedIcon: const Icon(Icons.history),
            label: l10n.navHistory,
          ),
          NavigationDestination(
            icon: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
            label: l10n.navAdd,
          ),
          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: l10n.navReports,
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu),
            selectedIcon: const Icon(Icons.menu_open),
            label: l10n.navMore,
          ),
        ],
      ),
    );
  }
}
