import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/theme/cubit/theme_cubit.dart';
import 'package:movify/core/theme/cubit/theme_state.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_header.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_radio_tile.dart';

/// Theme mode selection bottom sheet with design system tokens.
class ProfileThemeSheet extends StatelessWidget {
  const ProfileThemeSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ProfileThemeSheet(),
  );

  static const _modes = [
    (ThemeMode.dark, 'Dark mode'),
    (ThemeMode.light, 'Light mode'),
    (ThemeMode.system, 'System default'),
  ];

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
    builder: (context, state) {
      final currentMode = state.mode;

      return AppBottomSheet(
        title: 'Appearance',
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Space.lg,
            Space.xsm,
            Space.lg,
            Space.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBottomSheetHeader(
                title: 'Appearance',
                onClose: () => context.pop(),
              ),
              const SizedBox(height: Space.md),
              ...List.generate(_modes.length, (index) {
                final (mode, label) = _modes[index];
                final isSelected = currentMode == mode;

                return Padding(
                  padding: const EdgeInsets.only(bottom: Space.sm),
                  child: AppBottomSheetRadioTile(
                    title: label,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<ThemeCubit>().setThemeMode(mode);
                      context.pop();
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}
