import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/routing/route_name.dart';
import 'package:movify/features/auth/presentation/cubits/session_cubit.dart';
import 'package:movify/features/auth/presentation/cubits/session_state.dart';
import 'package:movify/features/profile/presentation/widgets/delete_account_sheet.dart';
import 'package:movify/features/profile/presentation/widgets/profile_section.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/features/profile/presentation/widgets/sign_out_sheet.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/utils/show_snack_bar.dart';

/// Account section managing sign-out and account deletion bottom sheets for authenticated users or sign-in for guests.
class ProfileAccountSection extends StatelessWidget {
  const ProfileAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return BlocBuilder<SessionCubit, SessionState>(
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
                  SignOutSheet.show(
                    context,
                    onConfirmSignOut: () {
                      context.read<SessionCubit>().signOut();
                    },
                  );
                },
              ),
              ProfileSettingTile(
                icon: Icons.delete_forever_rounded,
                title: l10n.deleteAccount,
                isDestructive: true,
                onTap: () {
                  DeleteAccountSheet.show(
                    context,
                    onConfirmDelete: () {
                      context.read<SessionCubit>().deleteAccount();
                      showSnackBar(
                        context,
                        color: colors.surfaceError,
                        text: l10n.accountDeleted,
                      );
                    },
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
    );
  }
}
