import 'package:flutter/material.dart';
import 'package:movify/core/design_system/components/app_chip.dart';
import 'package:movify/core/design_system/tokens/spacing.dart';
import 'package:movify/features/search/presentation/models/search_tab.dart';

/// Horizontal tabs bar rendering AppChips for SearchTab options.
class SearchTabsBar extends StatelessWidget {
  const SearchTabsBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  final SearchTab selectedTab;
  final ValueChanged<SearchTab> onTabSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 38,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,

      itemCount: SearchTab.values.length,
      separatorBuilder: (_, _) => const SizedBox(width: Space.sm),
      itemBuilder: (context, index) {
        final tab = SearchTab.values[index];
        return AppChip(
          label: tab.label,
          selected: tab == selectedTab,
          pill: true,
          onTap: () => onTabSelected(tab),
        );
      },
    ),
  );
}
