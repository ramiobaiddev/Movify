import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/theme/cubit/theme_cubit.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_selection_bottom_sheet.dart';

/// Theme mode selection bottom sheet utilizing [AppSelectionBottomSheet].
abstract final class ProfileThemeSheet {
  static const _modes = [
    AppSelectionOption('Dark mode', ThemeMode.dark),
    AppSelectionOption('Light mode', ThemeMode.light),
    AppSelectionOption('System default', ThemeMode.system),
  ];

  static Future<void> show(BuildContext context) async {
    final currentMode = context.read<ThemeCubit>().state.mode;

    final picked = await AppSelectionBottomSheet.show<ThemeMode>(
      context,
      title: 'Appearance',
      options: _modes,
      selectedValue: currentMode,
    );

    if (picked != null && context.mounted) {
      context.read<ThemeCubit>().setThemeMode(picked);
    }
  }
}
