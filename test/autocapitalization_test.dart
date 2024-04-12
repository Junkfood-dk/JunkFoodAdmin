import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';

void main() {
  testWidgets('Auto-capitalization for title and description fields', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: MaterialApp(
        home: PostDishPage(),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ));

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(milliseconds: 500));

    final titleFieldFinder = find.byKey(const Key('titleField'));
    final descriptionFieldFinder = find.byKey(const Key('descriptionField'));

    await tester.enterText(titleFieldFinder, 'test case');
    await tester.pump();

    await tester.enterText(descriptionFieldFinder, 'this is a test.');
    await tester.pump();

    expect((tester.widget(titleFieldFinder) as TextFormField).controller?.text, equals('Test Case'));
    expect((tester.widget(descriptionFieldFinder) as TextFormField).controller?.text, equals('This is a test.'));
  });
}
