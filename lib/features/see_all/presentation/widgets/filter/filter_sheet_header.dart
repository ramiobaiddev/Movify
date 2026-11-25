// import 'package:flutter/material.dart';
// import 'package:movify/core/design_system/design_system.dart';

// /// Header of the Filter Bottom Sheet with close icon, title, and Reset button.
// class FilterSheetHeader extends StatelessWidget {
//   const FilterSheetHeader({
//     super.key,
//     required this.onClose,
//     required this.onReset,
//   });

//   final VoidCallback onClose;
//   final VoidCallback onReset;

//   @override
//   Widget build(BuildContext context) {
//     final colors = context.colors;
//     final textTheme = Theme.of(context).textTheme;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         IconButton(
//           onPressed: onClose,
//           icon: Icon(Icons.close_rounded, color: colors.iconPrimary, size: 24),
//           splashRadius: 20,
//           padding: EdgeInsets.zero,
//           constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
//         ),
//         Text(
//           'Filters',
//           style: textTheme.titleMedium?.copyWith(
//             fontWeight: FontWeight.w700,
//             color: colors.textPrimary,
//           ),
//         ),
//         TextButton(
//           onPressed: onReset,
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: Space.sm),
//             minimumSize: const Size(40, 40),
//           ),
//           child: Text(
//             'Reset',
//             style: textTheme.labelLarge?.copyWith(
//               color: colors.primary300,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
