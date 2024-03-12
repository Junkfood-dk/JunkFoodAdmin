import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chefapp/main.dart';
import 'package:chefapp/Constants.dart';
import 'package:chefapp/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chefapp/fakeSupaBase.dart';


void main() {

  // SharedPreferences.setMockInitialValues({});
  final supabase = FakeSupabase();

  testWidgets('Sign In page shows', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginPage(database: supabase),
      ),
    );

    // Act
    final appBarFinder = find.byType(AppBar);
    final titleFinder = find.text('Sign In');
    final textInAppBarFinder = find.descendant(
      of: appBarFinder,
      matching: titleFinder,
    );

    //Assert
    expect(appBarFinder, findsOneWidget);
    expect(textInAppBarFinder, findsWidgets);
  });
}
