// test/features/auth/presentation/views/login_view_test.dart
//
// Pattern: Widget Testing â€” State â†’ UI Contract
//
// What we test:
// â”Œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”
// â”‚ LoginState      â”‚ Expected UI                               â”‚
// â”œâ”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”¤
// â”‚ LoginInitial    â”‚ Google button visible, no loading         â”‚
// â”‚ LoginLoading    â”‚ Loading indicator, button disabled        â”‚
// â”‚ LoginSuccess    â”‚ Green snackbar with 'Welcome !'           â”‚
// â”‚ LoginFailure    â”‚ Red snackbar with error message           â”‚
// â””â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”˜
//
// What we DO NOT test:
// - Navigation (router handles it â€” not LoginView's job)
// - LoginCubit logic (already tested in unit tests)
// - SessionCubit (not LoginView's concern)

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movify/features/auth/presentation/cubits/login_cubit.dart';
import 'package:movify/features/auth/presentation/cubits/login_state.dart';
import 'package:movify/features/auth/presentation/views/login_view.dart';
import 'package:movify/features/auth/presentation/views/login_view_body.dart';
import 'package:movify/shared/presentation/widgets/layout/size_config.dart';

// â”€â”€ Mocks â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

// Pattern: FAKE BLOC
// Never use real LoginCubit in widget tests.
// We control exact states â€” we are NOT testing Cubit logic here.
class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

// â”€â”€ Test setup â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

void main() {
  late MockLoginCubit mockLoginCubit;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
  });

  // â”€â”€ Builder helper â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // Pattern: buildWidget() helper
  // Single place to configure the widget tree for all tests.
  // MaterialApp is required for:
  //   - Scaffold (needs Material ancestor)
  //   - ScaffoldMessenger (needed for SnackBar)
  //   - Navigator (needed for any routing side effects)
  // BlocProvider.value injects our mock â€” NOT getIt
  Widget buildLoginView() => MaterialApp(
    home: BlocProvider<LoginCubit>.value(
      value: mockLoginCubit,
      child: const LoginView(),
    ),
  );

  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  // GROUP 1 â€” LoginInitial
  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  void setTheScreenSize(WidgetTester tester) {
    tester.view.physicalSize = const Size(SizeConfig.mobile, SizeConfig.tablet);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  group('1ï¸âƒ£ LoginInitial â€” default UI renders correctly', () {
    setUp(() {
      // Arrange: stub initial state
      when(() => mockLoginCubit.state).thenReturn(LoginInitial());
    });

    testWidgets('LoginViewBody is visible', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      expect(find.byType(LoginViewBody), findsOneWidget);
    });

    testWidgets('Google sign in button is visible', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      // SocialLoginButton with 'Google' title
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('no snackbar on initial state', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('no loading indicator on initial state', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });

  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  // GROUP 2 â€” LoginLoading
  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

  group('2ï¸âƒ£ LoginLoading â€” shows loading UI', () {
    setUp(() {
      when(() => mockLoginCubit.state).thenReturn(LoginLoading());
    });

    testWidgets('shows CircularProgressIndicator', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('no snackbar while loading', (tester) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      expect(find.byType(SnackBar), findsNothing);
    });
  });

  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  // GROUP 3 â€” LoginSuccess
  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

  group('3ï¸âƒ£ LoginSuccess â€” shows welcome snackbar', () {
    testWidgets('shows green snackbar with Welcome message', (tester) async {
      // Pattern: whenListen simulates a stream of states
      // Initial: LoginInitial (widget renders first)
      // Then:    LoginSuccess  (listener fires)
      whenListen(
        mockLoginCubit,
        Stream.fromIterable([LoginInitial(), LoginSuccess()]),
        initialState: LoginInitial(),
      );
      setTheScreenSize(tester);

      await tester.pumpWidget(buildLoginView());

      // Let BlocListener react to LoginSuccess
      await tester.pump();

      // Snackbar should appear
      expect(find.text('Welcome !'), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('LoginSuccess â†’ NO navigation from LoginView', (tester) async {
      // Navigation is router's job â€” LoginView must NOT call goNamed
      // This test verifies LoginView doesn't push any route itself
      whenListen(
        mockLoginCubit,
        Stream.fromIterable([LoginInitial(), LoginSuccess()]),
        initialState: LoginInitial(),
      );

      final mockObserver = _MockNavigatorObserver();
      setTheScreenSize(tester);

      await tester.pumpWidget(
        MaterialApp(
          navigatorObservers: [mockObserver],
          home: BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // No push should have happened from LoginView
      verifyNever(() => mockObserver.didPush(any(), any()));
    });
  });

  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  // GROUP 4 â€” LoginFailure
  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

  group('4ï¸âƒ£ LoginFailure â€” shows error snackbar', () {
    testWidgets('shows red snackbar with error message', (tester) async {
      const errorMessage = 'Sign in failed. Please try again.';

      whenListen(
        mockLoginCubit,
        Stream.fromIterable([
          LoginInitial(),
          const LoginFailure(message: errorMessage),
        ]),
        initialState: LoginInitial(),
      );
      setTheScreenSize(tester);

      await tester.pumpWidget(buildLoginView());
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows snackbar with different error messages', (tester) async {
      // Verify the message is dynamic â€” not hardcoded
      const errorMessage = 'Network error. Check your connection.';

      whenListen(
        mockLoginCubit,
        Stream.fromIterable([
          LoginInitial(),
          const LoginFailure(message: errorMessage),
        ]),
        initialState: LoginInitial(),
      );
      setTheScreenSize(tester);

      await tester.pumpWidget(buildLoginView());
      await tester.pump();

      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('LoginFailure â†’ stays on LoginView (no navigation)', (
      tester,
    ) async {
      whenListen(
        mockLoginCubit,
        Stream.fromIterable([
          LoginInitial(),
          const LoginFailure(message: 'error'),
        ]),
        initialState: LoginInitial(),
      );
      setTheScreenSize(tester);

      await tester.pumpWidget(buildLoginView());
      await tester.pumpAndSettle();

      // Still on login view after failure
      expect(find.byType(LoginViewBody), findsOneWidget);
    });
  });

  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
  // GROUP 5 â€” Interactions
  // Tapping Google button â†’ dispatches signInWithGoogle()
  // â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•

  group('5ï¸âƒ£ Interactions â€” user gestures dispatch correct cubit methods', () {
    setUp(() {
      when(() => mockLoginCubit.state).thenReturn(LoginInitial());
      // Stub the method so it doesn't throw when called
      when(() => mockLoginCubit.signInWithGoogle()).thenAnswer((_) async {});
    });

    testWidgets('tapping Google button â†’ calls signInWithGoogle()', (
      tester,
    ) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      // Find and tap the Google button
      await tester.tap(find.text('Continue with Google'));
      await tester.pump();

      // Verify cubit method was called exactly once
      verify(() => mockLoginCubit.signInWithGoogle()).called(1);
    });

    testWidgets('Google button not tapped â†’ signInWithGoogle not called', (
      tester,
    ) async {
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());

      // Counterpart rule â€” verify NOT called without interaction
      verifyNever(() => mockLoginCubit.signInWithGoogle());
    });
  });

  group('User Cancell Login  ', () {
    testWidgets('User Cancell Login  ', (tester) async {
      whenListen(
        mockLoginCubit,
        Stream.fromIterable([LoginInitial(), LoginLoading(), LoginInitial()]),
        initialState: LoginInitial(),
      );
      setTheScreenSize(tester);
      await tester.pumpWidget(buildLoginView());
      await tester.pump();

      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(LoginViewBody), findsOneWidget);
    });
  });
}

// â”€â”€ Private helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

// Minimal NavigatorObserver mock for verifying no navigation happens
class _MockNavigatorObserver extends Mock implements NavigatorObserver {}
