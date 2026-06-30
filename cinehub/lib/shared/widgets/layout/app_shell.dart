import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/theme.dart';

/// Main app shell with persistent bottom navigation bar.
///
/// Uses GoRouter's ShellRoute to persist navigation state across tabs.
class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/discover')) return 1;
    if (location.startsWith('/ai')) return 2;
    if (location.startsWith('/opportunities')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.divider, width: 0.5),
          ),
        ),
        child: NavigationBar(
          selectedIndex: currentIndex,
          backgroundColor: AppColors.surface,
          indicatorColor: AppColors.primaryMuted,
          surfaceTintColor: Colors.transparent,
          height: 64,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) => _onTap(context, index),
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home, size: 22),
              selectedIcon:
                  Icon(Iconsax.home_15, size: 22, color: AppColors.primary),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.search_normal, size: 22),
              selectedIcon: Icon(Iconsax.search_normal_1,
                  size: 22, color: AppColors.primary),
              label: 'Discover',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.cpu, size: 22),
              selectedIcon:
                  Icon(Iconsax.cpu, size: 22, color: AppColors.primary),
              label: 'AI Studio',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.briefcase, size: 22),
              selectedIcon:
                  Icon(Iconsax.briefcase, size: 22, color: AppColors.primary),
              label: 'Jobs',
            ),
            NavigationDestination(
              icon: Icon(Iconsax.user, size: 22),
              selectedIcon:
                  Icon(Iconsax.user, size: 22, color: AppColors.primary),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
      case 1:
        context.go('/discover');
      case 2:
        context.go('/ai');
      case 3:
        context.go('/opportunities');
      case 4:
        context.go('/profile');
    }
  }
}
