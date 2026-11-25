// import 'package:flutter/material.dart';
// import 'package:movify/core/design_system/design_system.dart';
// import 'package:movify/features/see_all/presentation/widgets/filter/filter_sort_radio_tile.dart';
// import 'package:movify/shared/domain/enums/discover_sort.dart';

// /// Column of sort option tiles for DiscoverSort enum values.
// class FilterSortOptions extends StatelessWidget {
//   const FilterSortOptions({
//     super.key,
//     required this.selectedSort,
//     required this.onSortChanged,
//   });

//   final DiscoverSort selectedSort;
//   final ValueChanged<DiscoverSort> onSortChanged;

//   @override
//   Widget build(BuildContext context) => Column(
//     children: [
//       FilterSortRadioTile(
//         title: 'Popularity',
//         isSelected: selectedSort == DiscoverSort.popularity,
//         onTap: () => onSortChanged(DiscoverSort.popularity),
//       ),
//       const SizedBox(height: Space.sm),
//       FilterSortRadioTile(
//         title: 'Rating',
//         isSelected: selectedSort == DiscoverSort.rating,
//         onTap: () => onSortChanged(DiscoverSort.rating),
//       ),
//       const SizedBox(height: Space.sm),
//       FilterSortRadioTile(
//         title: 'Release date (Newest)',
//         isSelected: selectedSort == DiscoverSort.newest,
//         onTap: () => onSortChanged(DiscoverSort.newest),
//       ),
//       const SizedBox(height: Space.sm),
//       FilterSortRadioTile(
//         title: 'Release date (Oldest)',
//         isSelected: selectedSort == DiscoverSort.oldest,
//         onTap: () => onSortChanged(DiscoverSort.oldest),
//       ),
//     ],
//   );
// }
