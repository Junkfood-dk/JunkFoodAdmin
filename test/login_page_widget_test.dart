import 'package:chefapp/model/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefapp/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'fakeSupaBase.dart';

void main() {
  // SharedPreferences.setMockInitialValues({});
  final supabase = FakeSupabase();

  testWidgets('Sign In page shows', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => LocaleModel())
        ], child: LoginPage(database: supabase)),
      ),
    );

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
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => LocaleModel())
        ], child: LoginPage(database: supabase)),
      ),
    );

    // Act
    await tester.enterText(find.bySemanticsLabel('Email'), 'test@nytest.dk');
    await tester.enterText(find.bySemanticsLabel('Password'), '12');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Sign In'));
    await tester.pumpAndSettle();

    final snackBarFinder = find.byType(SnackBar);
    final textFinder = find.text('Invalid login credentials');
    final textOnSnackBarFinder = find.descendant(
      of: snackBarFinder,
      matching: textFinder,
    );

    //Assert
    expect(textOnSnackBarFinder, findsWidgets);
  });

  testWidgets('Sign In succeeds with valid credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MultiProvider(providers: [
          ChangeNotifierProvider(create: (context) => LocaleModel())
        ], child: LoginPage(database: supabase)),
      ),
    );

    // Act
    await tester.enterText(find.bySemanticsLabel('Email'), 'test@nytest.dk');
    await tester.enterText(find.bySemanticsLabel('Password'), '1234');
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
}
