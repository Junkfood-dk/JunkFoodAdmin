import 'package:chefapp/Data/user_repository.dart';
import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<UserRepository>()])

void main() {
  testWidgets('Sign In page shows', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        child: Consumer(
      builder: (context, ref, child) => MaterialApp(
          locale: ref.watch(localeControllerProvider),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const LoginPage()),
    )));

    // Act
    final appBarFinder = find.byType(AppBar);
    final titleFinder = find.text('Sign In');
    final textInAppBarFinder = find.descendant(
      of: appBarFinder,
      matching: titleFinder,
    );
    final formFieldFinder = find.byType(TextFormField);
    final emailLabelFinder = find.text('Email');
    final passwordLabelFinder = find.text('Password');

    final emailFormFieldFinder = find.descendant(
      of: formFieldFinder,
      matching: emailLabelFinder,
    );
    final passwordFormFieldFinder = find.descendant(
      of: formFieldFinder,
      matching: passwordLabelFinder,
    );

    final signInButtonFinder = find.widgetWithText(ElevatedButton, 'Sign In');

    //Assert
    expect(appBarFinder, findsOneWidget);
    expect(textInAppBarFinder, findsOneWidget);
    expect(emailFormFieldFinder, findsOneWidget);
    expect(passwordFormFieldFinder, findsOneWidget);
    expect(signInButtonFinder, findsOneWidget);
  });

   testWidgets('Sign In fails with invalid credentials',
      (WidgetTester tester) async {
    final mockUserRepository = MockUserRepository();
    AuthException exp = const AuthException("Invalid login credentials", statusCode: "400");
    when(mockUserRepository.signUserIn("", ""))
        // ignore: void_checks
        .thenAnswer((realInvocation) => Future.value(throw exp));
    await tester.pumpWidget(ProviderScope(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
        child: Consumer(
          builder: (context, ref, child) => const MaterialApp(
              locale: Locale('en'),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: LoginPage()),
        )));
    // Act
    await tester.enterText(find.bySemanticsLabel('Email'), '');
    await tester.enterText(find.bySemanticsLabel('Password'), '');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    final snackBarFinder = find.byType(SnackBar);
    final textFinder =
        find.text('Unexpected error occurredAuthException(message: Invalid login credentials, statusCode: 400)');
    final textOnSnackBarFinder = find.descendant(
      of: snackBarFinder,
      matching: textFinder,
    );

    //Assert
    expect(textOnSnackBarFinder, findsWidgets);
  });

  testWidgets('Sign In succeeds with valid credentials',
      (WidgetTester tester) async {
    final mockUserRepository = MockUserRepository();
    AuthResponse authR = AuthResponse(session: Session(
                accessToken: 'mocked_access_token',
                refreshToken: 'mocked_refresh_token',
                tokenType: 'bearer',
                user: User(
                  id: 'mocked_user_id',
                  email: "test@test.dk",
                  createdAt: DateTime.now().toString(),
                  updatedAt: DateTime.now().toString(),
                  appMetadata: {},
                  userMetadata: {},
                  aud: '',
                ),
              ),);
    // ignore: void_checks
    when(mockUserRepository.signUserIn("test@test.dk", "SecurePassword1234"))
        // ignore: void_checks
        .thenAnswer((realInvocation) => Future.value(authR));
    await tester.pumpWidget(ProviderScope(
        overrides: [
          userRepositoryProvider.overrideWithValue(mockUserRepository),
        ],
        child: Consumer(
          builder: (context, ref, child) => MaterialApp(
              locale: ref.watch(localeControllerProvider),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const LoginPage()),
        )));

    // Act
    await tester.enterText(find.bySemanticsLabel('Email'), 'test@test.dk');
    await tester.enterText(find.bySemanticsLabel('Password'), 'SecurePassword1234');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();
    final snackBarFinder = find.byType(SnackBar);
    final textFinder = find.text('Sign in successful!');
    final textOnSnackBarFinder = find.descendant(
      of: snackBarFinder,
      matching: textFinder,
    );
    //Assert
    expect(textOnSnackBarFinder, findsWidgets);
  });

//This test checks if the language selection dropdown is present on the login screen

  testWidgets('Pop up menu button for language selection exists on login page',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
        child: Consumer(
          builder: (context, ref, child) => const MaterialApp(
              locale: Locale('en'),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: LoginPage()),
        )));

    //Act

    final appBarFinder = find.byType(AppBar);
    final popupMenuButtonFinder = find.byType(LanguageDropdownWidget);
    final buttonInAppBarFinder =
        find.descendant(of: appBarFinder, matching: popupMenuButtonFinder);

    //Assert
    expect(appBarFinder, findsOneWidget);
    expect(popupMenuButtonFinder, findsOneWidget);
    expect(buttonInAppBarFinder, findsOneWidget);
  });
}
