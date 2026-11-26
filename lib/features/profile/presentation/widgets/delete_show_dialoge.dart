import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movify/core/design_system/design_system.dart';
import 'package:movify/features/auth/presentation/cubits/session_cubit.dart';
import 'package:movify/l10n/app_localizations.dart';
import 'package:movify/shared/presentation/utils/show_snack_bar.dart';

class DeleteShowDialoge extends StatelessWidget {
  const DeleteShowDialoge({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionCubit = context.read<SessionCubit>();
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      backgroundColor: colors.surfaceContainerTonal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      actionsAlignment: MainAxisAlignment.center,
      insetPadding: const EdgeInsets.symmetric(horizontal: Space.xl),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_forever_outlined,
            size: 28,
            color: colors.surfaceError,
          ),
          const SizedBox(width: Space.sm),
          Flexible(
            child: Text(
              l10n.areYouSureYouWantToDelete,
              style: textTheme.titleMedium?.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
      content: Text(
        l10n.thisActionCannotBeUndone,
        style: textTheme.bodyMedium?.copyWith(
          color: colors.textSecondary,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.textSecondary,
            side: BorderSide(color: colors.surfaceDivider),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.md),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: colors.surfaceError,
            side: BorderSide(color: colors.surfaceError),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.md),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            sessionCubit.deleteAccount();
            showSnackBar(
              context,
              color: colors.surfaceError,
              text: l10n.accountDeleted,
            );
          },
          child: Text(l10n.delete),
        ),
      ],
    );
  }
}
