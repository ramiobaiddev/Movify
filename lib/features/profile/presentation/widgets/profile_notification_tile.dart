import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/core/di/service_locator.dart';
import 'package:movify/core/notification/settings/presentation/notification_settings/notification_settings_cubit.dart';
import 'package:movify/features/profile/presentation/widgets/profile_setting_tile.dart';
import 'package:movify/l10n/app_localizations.dart';

/// Notification toggle tile within profile settings.
class ProfileNotificationTile extends StatelessWidget {
  const ProfileNotificationTile({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<NotificationSettingsCubit>(),
    child: const _ProfileNotificationTileContent(),
  );
}

class _ProfileNotificationTileContent extends StatefulWidget {
  const _ProfileNotificationTileContent();

  @override
  State<_ProfileNotificationTileContent> createState() =>
      _ProfileNotificationTileContentState();
}

class _ProfileNotificationTileContentState
    extends State<_ProfileNotificationTileContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<NotificationSettingsCubit>().checkStatus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationSettingsCubit>().checkStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
      builder: (context, state) {
        final isEnabled = switch (state) {
          NotificationSettingsLoaded(:final isEnabled) => isEnabled,
          _ => false,
        };
        final isLoading = state is NotificationSettingsLoading;

        return ProfileSettingTile(
          icon: Icons.notifications_none_rounded,
          title: l10n.pushNotifications,
          trailing: isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(colors.buttonPrimary),
                  ),
                )
              : CupertinoSwitch(
                  value: isEnabled,
                  activeTrackColor: colors.buttonPrimary,
                  onChanged: (value) {
                    context
                        .read<NotificationSettingsCubit>()
                        .toggleNotification(value);
                  },
                ),
          onTap: isLoading
              ? null
              : () {
                  context.read<NotificationSettingsCubit>().toggleNotification(
                    !isEnabled,
                  );
                },
        );
      },
    );
  }
}
