// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:movify/core/design_system/tokens/app_colors.dart';
// import 'package:movify/core/design_system/tokens/spacing.dart';
// import 'package:movify/features/search/presentation/cubits/search_cubit/search_cubit.dart';
// import 'package:movify/features/search/presentation/widgets/search_text_field.dart';

// class SearchViewBar extends StatefulWidget {
//   const SearchViewBar({super.key});

//   @override
//   State<SearchViewBar> createState() => _SearchViewBarState();
// }

// class _SearchViewBarState extends State<SearchViewBar> {
//   void _onQueryChanged(String query) {
//     context.read<SearchCubit>().onQueryChanged(query);
//   }

//   void _onClear() {
//     context.read<SearchCubit>().onQueryChanged('');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final colors = context.colors;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: Space.lg),
//       child: Row(
//         children: [
//           if (Navigator.of(context).canPop()) ...[
//             IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios_new_rounded,
//                 color: colors.iconPrimary,
//                 size: 20,
//               ),
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
//               onPressed: () => context.pop(),
//             ),
//             const SizedBox(width: Space.xsm),
//           ],
//           Expanded(
//             child: SearchTextField(
//               controller: _textController,
//               onChanged: _onQueryChanged,
//               onClear: _onClear,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
