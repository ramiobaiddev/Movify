import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/ads/consent_manager.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/language/presentation/cubits/language_cubit.dart';
import 'package:movify/core/language/presentation/cubits/language_state.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/core/theme/cubit/theme_cubit.dart';
import 'package:movify/core/theme/cubit/theme_state.dart';
import 'package:movify/features/auth/presentation/cubits/session_cubit.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';
import 'package:movify/features/profile/presentation/widgets/clear_viewing_history_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/delete_show_dialoge.dart';
import 'package:movify/features/profile/presentation/widgets/profile_language_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/profile_notification_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/features/profile/presentation/widgets/profile_theme_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/profile_user_card.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/utils/show_snack_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Body of the Profile screen matching Figma node `413:3939`.
class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Space.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Space.md),
          Text(
            l10n.profile,
            style: textTheme.titleLarge?.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: Space.lg),
          const ProfileUserCard(),
          const SizedBox(height: Space.xl),

          // 1. Preferences
          ProfileSection(
            title: 'Preferences',
            children: [
              const ProfileNotificationTile(),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, themeState) {
                  final themeLabel = switch (themeState.mode) {
                    ThemeMode.dark => 'Dark',
                    ThemeMode.light => 'Light',
                    ThemeMode.system => 'System default',
                  };
                  return ProfileSettingTile(
                    icon: Icons.palette_outlined,
                    title: l10n.theme,
                    value: themeLabel,
                    onTap: () => ProfileThemeSheet.show(context),
                  );
                },
              ),
              BlocBuilder<LanguageCubit, LanguageState>(
                builder: (context, languageState) {
                  final langLabel = switch (languageState.locale.languageCode) {
                    'ar' => 'العربية',
                    'tr' => 'Türkçe',
                    'es' => 'Español',
                    'fr' => 'Français',
                    _ => 'English',
                  };
                  return ProfileSettingTile(
                    icon: Icons.language_rounded,
                    title: l10n.language,
                    value: langLabel,
                    onTap: () => ProfileLanguageSheet.show(context),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: Space.xl),

          // 2. Your data
          ProfileSection(
            title: 'Your data',
            children: [
              ProfileSettingTile(
                icon: Icons.history_rounded,
                title: 'Viewing history',
                onTap: () {
                  ClearViewingHistorySheet.show(
                    context,
                    onConfirmClear: () {
                      showSnackBar(
                        context,
                        text: 'Viewing history cleared',
                        color: colors.surfaceSuccess,
                      );
                    },
                  );
                },
              ),
              ProfileSettingTile(
                icon: Icons.search_rounded,
                title: l10n.searchHistory,
                onTap: () {
                  context.pushNamed(RouteName.search);
                },
              ),
            ],
          ),
          const SizedBox(height: Space.xl),

          // 3. Support & legal
          ProfileSection(
            title: 'Support & legal',
            children: [
              ProfileSettingTile(
                icon: Icons.star_outline_rounded,
                title: 'Rate Movify',
                onTap: () {
                  showSnackBar(
                    context,
                    text: 'Thank you for your rating!',
                    color: colors.surfaceSuccess,
                  );
                },
              ),
              ProfileSettingTile(
                icon: Icons.share_outlined,
                title: l10n.share,
                onTap: () {
                  Share.share(
                    'Check out Movify: your ultimate movies and series companion!',
                  );
                },
              ),
              ProfileSettingTile(
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Send feedback',
                onTap: () async {
                  final uri = Uri.parse(
                    'mailto:support@movify.app?subject=Movify%20App%20Feedback',
                  );
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),
              ProfileSettingTile(
                icon: Icons.privacy_tip_outlined,
                title: l10n.privacySettings,
                onTap: () async {
                  await ConsentManager.showPrivacyOptionsForm();
                },
              ),
            ],
          ),
          const SizedBox(height: Space.xl),

          // 4. Account
          BlocBuilder<SessionCubit, SessionState>(
            builder: (context, sessionState) {
              final isGuest = sessionState is! SessionAuthenticated;

              return ProfileSection(
                title: 'Account',
                children: [
                  if (!isGuest) ...[
                    ProfileSettingTile(
                      icon: Icons.logout_rounded,
                      title: l10n.authLogout,
                      onTap: () {
                        context.read<SessionCubit>().signOut();
                      },
                    ),
                    ProfileSettingTile(
                      icon: Icons.delete_forever_rounded,
                      title: l10n.deleteAccount,
                      isDestructive: true,
                      onTap: () {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const DeleteShowDialoge(),
                        );
                      },
                    ),
                  ] else
                    ProfileSettingTile(
                      icon: Icons.login_rounded,
                      title: l10n.authLogin,
                      onTap: () {
                        context.pushNamed(RouteName.login);
                      },
                    ),
                ],
              );
            },
          ),

          // Safe padding to account for floating bottom navigation bar
          const SizedBox(height: Space.x3xl),
        ],
      ),
    );
  }
}
