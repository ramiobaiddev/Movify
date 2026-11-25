// import 'package:flutter/material.dart';
// import 'package:movify/core/design_system/design_system.dart';

// /// Squircle filter button with active count badge.
// class SeeAllFilterButton extends StatelessWidget {
//   const SeeAllFilterButton({
//     super.key,
//     required this.activeCount,
//     this.onTap,
//   });

//   final int activeCount;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     final colors = context.colors;
//     final textStyles = context.textStyles;

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(Radii.lg),
//         child: Ink(
//           width: 44,
//           height: 44,
//           decoration: BoxDecoration(
//             color: colors.surfaceContainerTonal,
//             borderRadius: BorderRadius.circular(Radii.lg),
//             border: Border.all(
//               color: colors.surfaceDivider.withValues(alpha: 0.5),
//             ),
//           ),
//           child: Stack(
//             alignment: Alignment.center,
//             clipBehavior: Clip.none,
//             children: [
//               Icon(
//                 Icons.tune_rounded,
//                 color: colors.iconPrimary,
//                 size: 20,
//               ),
//               if (activeCount > 0)
//                 Positioned(
//                   top: -4,
//                   right: -4,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: Space.xsm,
//                       vertical: 2,
//                     ),
//                     constraints: const BoxConstraints(
//                       minWidth: 18,
//                       minHeight: 18,
//                     ),
//                     decoration: BoxDecoration(
//                       color: colors.surfaceGenreSelected,
//                       borderRadius: BorderRadius.circular(Radii.full),
//                     ),
//                     alignment: Alignment.center,
//                     child: Text(
//                       activeCount > 99 ? '99+' : '$activeCount',
//                       style: textStyles.bodyXxs.copyWith(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 10,
//                         height: 1.1,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
