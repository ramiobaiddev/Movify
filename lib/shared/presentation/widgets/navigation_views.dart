import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movify/core/ads/consent_manager.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/widgets/floating_bottom_bar/floating_bottom_bar.dart';

class NavigationViews extends HookWidget {
  const NavigationViews({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    useMemoized(() async {
      ConsentManager.initialize(
        onConsentGathered: () async {
          final canRequestAds = await ConsentManager.canRequestAds();
          if (canRequestAds) {
            await MobileAds.instance.initialize();
          }
        },
      );
    });

    return PopScope(
      canPop: navigationShell.currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          _onItemTapped(0, context);
        }
      },
      child: Scaffold(
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: FloatingBottomBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (index) => _onItemTapped(index, context),
          destinations: NavigationItems.values
              .map(
                (item) => FloatingBottomBarDestination(
                  label: item.localizedLabel(context),
                  selectedIcon: item.selectedIcon,
                  unselectedIcon: item.unselectedIcon,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _onItemTapped(int index, BuildContext context) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

enum NavigationItems { home, discover, favorite, profile }

extension NavigationItemsExtension on NavigationItems {
  String localizedLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      NavigationItems.home => l10n.home,
      NavigationItems.discover => l10n.discover,
      NavigationItems.favorite => l10n.favorites,
      NavigationItems.profile => l10n.profile,
    };
  }

  IconData get selectedIcon => switch (this) {
    NavigationItems.home => Icons.home_rounded,
    NavigationItems.discover => Icons.search_rounded,
    NavigationItems.favorite => Icons.favorite_rounded,
    NavigationItems.profile => Icons.person_rounded,
  };

  IconData get unselectedIcon => switch (this) {
    NavigationItems.home => Icons.home_outlined,
    NavigationItems.discover => Icons.search_rounded,
    NavigationItems.favorite => Icons.favorite_border_rounded,
    NavigationItems.profile => Icons.person_outline_rounded,
  };
}
