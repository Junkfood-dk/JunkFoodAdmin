import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/ui/pages/post_dish_page.dart';

void main() {
  testWidgets('Auto-capitalization for title and description fields',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
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
      ),
    );

    await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout
    await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout

    final titleFieldFinder = find.byKey(const Key('titleField'));
    final descriptionFieldFinder = find.byKey(const Key('descriptionField'));

    await tester.enterText(titleFieldFinder, 'test case');
    await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout
    await tester.enterText(descriptionFieldFinder, 'this is a test.');
    await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout

    expect(
      (tester.widget(titleFieldFinder) as TextFormField).controller?.text,
      equals('Test Case'),
    );
    expect(
      (tester.widget(descriptionFieldFinder) as TextFormField).controller?.text,
      equals('This is a test.'),
    );

    final titleFieldTestCases = [
      {'input': 'copenhagen', 'expected': 'Copenhagen'},
      {'input': 'æblegrød', 'expected': 'Æblegrød'},
      {'input': 'økonomi', 'expected': 'Økonomi'},
      {'input': 'Århus', 'expected': 'Århus'},
      {'input': '', 'expected': ''},
    ];

    final descriptionFieldTestCases = [
      {'input': 'this is a test.', 'expected': 'This is a test.'},
      {
        'input': 'this is a test. this is another test.',
        'expected': 'This is a test. This is another test.',
      },
      {'input': 'this ends with space. ', 'expected': 'This ends with space. '},
      {
        'input': 'hello! how are you? i\'m fine.',
        'expected': 'Hello! How are you? I\'m fine.',
      },
      {
        'input': 'section 3.2 starts here: the test.',
        'expected': 'Section 3.2 starts here: the test.',
      },
      {
        'input': 'détente. œuvre. naïve. café.',
        'expected': 'Détente. Œuvre. Naïve. Café.',
      },
      {
        'input': '123 times are fun times. okay?',
        'expected': '123 times are fun times. Okay?',
      },
      {
        'input': 'æblegrød er godt. økonomi er vigtig. Århus er smuk.',
        'expected': 'Æblegrød er godt. Økonomi er vigtig. Århus er smuk.',
      },
      {'input': '', 'expected': ''},
    ];

    for (var testCase in titleFieldTestCases) {
      await tester.enterText(titleFieldFinder, testCase['input']!);
      await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout
      expect(
        (tester.widget(titleFieldFinder) as TextFormField).controller?.text,
        equals(testCase['expected']),
      );
    }

    for (var testCase in descriptionFieldTestCases) {
      await tester.enterText(descriptionFieldFinder, testCase['input']!);
      await tester.pump(const Duration(milliseconds: 100)); // to avoid timeout
      expect(
        (tester.widget(descriptionFieldFinder) as TextFormField)
            .controller
            ?.text,
        equals(testCase['expected']),
      );
    }
  });
}
