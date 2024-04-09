import 'package:chefapp/Data/dish_repository.dart';
import 'package:chefapp/Domain/Model/dish_model.dart';
import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/UI/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_page_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DishRepository>()])
void main() {
  testWidgets('HomePage shows the AppBar with the expected title',
      (WidgetTester tester) async {
    final mockDishRepository = MockDishRepository();
    when(mockDishRepository.fetchDishOfTheDay())
        .thenAnswer((realInvocation) => Future.value(<DishModel>[]));
    await tester.pumpWidget(ProviderScope(
        overrides: [
          dishRepositoryProvider.overrideWithValue(mockDishRepository),
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
              home: const HomePage()),
        )));

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
