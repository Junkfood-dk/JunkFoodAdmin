import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:chefapp/model/locale.dart';
import 'package:chefapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'fakeSupaBase.dart';

void main() {
  testWidgets('HomePage shows the AppBar with the expected title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => LocaleModel()),
          ChangeNotifierProvider<DishOfTheDayModel>(
              create: (context) => DishOfTheDayModel(database: FakeSupabase()))
        ],
        child: const MaterialApp(
            localizationsDelegates: [AppLocalizations.delegate],
            home: HomePage())));

    final appBarFinder = find.byType(AppBar);
    final titleFinder = find.text('Homepage');
    final textInAppBarFinder = find.descendant(
      of: appBarFinder,
      matching: titleFinder,
    );

    expect(appBarFinder, findsOneWidget);
    expect(textInAppBarFinder, findsOneWidget);
  });
}
