import 'package:flutter_test/flutter_test.dart';
import 'package:movify/features/favorite/presentation/cubits/sign_in_prompt_cubit.dart';

import '../../helpers/hydrated_storage.dart';

void main() {
  final start = DateTime(2026, 1, 1);

  group('SignInPromptState.canShow', () {
    test('shows when never dismissed', () {
      expect(const SignInPromptState().canShow(start), isTrue);
    });

    test('hides during the cooldown after the first dismissal', () {
      final state = SignInPromptState(dismissCount: 1, lastDismissedAt: start);

      expect(state.canShow(start.add(const Duration(days: 13))), isFalse);
    });

    test('comes back once the cooldown has passed', () {
      final state = SignInPromptState(dismissCount: 1, lastDismissedAt: start);

      expect(state.canShow(start.add(const Duration(days: 14))), isTrue);
    });

    test('stays hidden for good after the second dismissal', () {
      final state = SignInPromptState(dismissCount: 2, lastDismissedAt: start);

      expect(state.canShow(start.add(const Duration(days: 365))), isFalse);
    });
  });

  group('SignInPromptCubit', () {
    setUp(initHydratedStorage);

    test('dismiss counts and stamps the time', () {
      final cubit = SignInPromptCubit(clock: () => start)..dismiss();

      expect(cubit.state.dismissCount, 1);
      expect(cubit.state.lastDismissedAt, start);
    });

    test('state survives a round trip through json', () {
      final cubit = SignInPromptCubit(clock: () => start);
      final original = SignInPromptState(dismissCount: 1, lastDismissedAt: start);

      expect(cubit.fromJson(cubit.toJson(original)!), original);
    });
  });
}
