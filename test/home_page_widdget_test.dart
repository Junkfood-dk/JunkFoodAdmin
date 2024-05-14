import 'package:chefapp/Data/dish_repository.dart';
import 'package:chefapp/Domain/model/dish_model.dart';
import 'package:chefapp/Domain/model/dish_type_model.dart';
import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/UI/pages/home_page.dart';
import 'package:chefapp/Utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:network_image_mock/network_image_mock.dart';

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

  testWidgets(
      'HomePage shows the option to add dish with one dish already in database',
      (WidgetTester tester) async {
    final mockDishRepository = MockDishRepository();
    when(mockDishRepository.fetchDishOfTheDay()).thenAnswer((realInvocation) =>
        Future.value(<DishModel>[
          DishModel(
              title: 'Test1',
              dishType: DishTypeModel(id: -1, type: 'Main Course'))
        ]));
    mockNetworkImagesFor(() async {
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
      await tester.pump();

      final textButtonFinder = find.byType(GradiantButton);
      final textFinder = find.text('Add dish');
      final textInTextButtonFinder = find.descendant(
        of: textButtonFinder,
        matching: textFinder,
      );

      expect(textButtonFinder, findsOneWidget);
      expect(textInTextButtonFinder, findsOneWidget);
    });
  });

  testWidgets(
      'HomePage shows the option to add dish with two dishes already in database',
      (WidgetTester tester) async {
    final mockDishRepository = MockDishRepository();
    when(mockDishRepository.fetchDishOfTheDay())
        .thenAnswer((realInvocation) => Future.value(<DishModel>[
              DishModel(
                  title: 'Test1',
                  dishType: DishTypeModel(id: -1, type: 'Main Course')),
              DishModel(
                  title: 'Test2',
                  dishType: DishTypeModel(id: -1, type: 'Dessert'))
            ]));
    mockNetworkImagesFor(() async {
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
      await tester.pump();

      final textButtonFinder = find.byType(GradiantButton);
      final textFinder = find.text('Add dish');
      final textInTextButtonFinder = find.descendant(
        of: textButtonFinder,
        matching: textFinder,
      );

      expect(textButtonFinder, findsOneWidget);
      expect(textInTextButtonFinder, findsOneWidget);
    });
  });
}
