import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

/// How often the "keep your favorites safe" card may bother a guest.
///
/// A dismissal hides the card for [cooldown]. After [maxDismissals] it stays
/// hidden for good. Signing in hides it anyway, because it only shows to
/// guests.
class SignInPromptState extends Equatable {
  const SignInPromptState({this.dismissCount = 0, this.lastDismissedAt});

  static const int maxDismissals = 2;
  static const Duration cooldown = Duration(days: 14);

  final int dismissCount;
  final DateTime? lastDismissedAt;

  bool canShow(DateTime now) {
    if (dismissCount == 0 || lastDismissedAt == null) {
      return true;
    }
    return dismissCount < maxDismissals &&
        now.difference(lastDismissedAt!) >= cooldown;
  }

  @override
  List<Object?> get props => [dismissCount, lastDismissedAt];
}

class SignInPromptCubit extends HydratedCubit<SignInPromptState> {
  SignInPromptCubit({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      super(const SignInPromptState());

  final DateTime Function() _clock;

  DateTime get now => _clock();

  void dismiss() => emit(
    SignInPromptState(
      dismissCount: state.dismissCount + 1,
      lastDismissedAt: _clock(),
    ),
  );

  @override
  Map<String, dynamic> toJson(SignInPromptState state) => {
    'count': state.dismissCount,
    'at': state.lastDismissedAt?.toIso8601String(),
  };

  @override
  SignInPromptState? fromJson(Map<String, dynamic> json) => SignInPromptState(
    dismissCount: (json['count'] as num?)?.toInt() ?? 0,
    lastDismissedAt: DateTime.tryParse(json['at'] as String? ?? ''),
  );
}
