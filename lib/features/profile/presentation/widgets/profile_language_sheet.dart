import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/language/presentation/cubits/language_cubit.dart';
import 'package:movify/core/language/presentation/cubits/language_state.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_header.dart';
import 'package:movify/shared/presentation/widgets/bottom_sheet/app_bottom_sheet_radio_tile.dart';

/// Language selection bottom sheet matching Figma node `567:3796`.
class ProfileLanguageSheet extends StatelessWidget {
  const ProfileLanguageSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ProfileLanguageSheet(),
  );

  static const _supportedLanguages = [
    ('en', 'English'),
    ('ar', 'العربية'),
    ('tr', 'Türkçe'),
    ('es', 'Español'),
    ('fr', 'Français'),
  ];

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          final currentCode = state.locale.languageCode;

          return AppBottomSheet(
            title: 'Language',
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
                    title: 'Language',
                    onClose: () => context.pop(),
                  ),
                  const SizedBox(height: Space.md),
                  ...List.generate(_supportedLanguages.length, (index) {
                    final (code, name) = _supportedLanguages[index];
                    final isSelected = currentCode == code;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: Space.sm),
                      child: AppBottomSheetRadioTile(
                        title: name,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<LanguageCubit>().changeLanguage(code);
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
