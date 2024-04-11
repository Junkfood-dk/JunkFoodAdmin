import 'package:chefapp/Data/allergenes_repository.dart';
import 'package:chefapp/Data/categories_repository.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'muteable_checkbow_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoriesRepository>()])
@GenerateNiceMocks([MockSpec<AllergenesRepository>()])
void main() {
  testWidgets('PostDishPage should contain text with "category" and "allergen"',
      (WidgetTester tester) async {
    final mockCategoryRepositoryProvider = MockCategoriesRepository();
    await tester.pumpWidget(ProviderScope(
        overrides: [
          categoriesRepositoryProvider
              .overrideWithValue(mockCategoryRepositoryProvider),
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
              home: PostDishPage()),
        )));

    await tester.pump();

    final categoryTextFinder =
        find.textContaining(RegExp('category', caseSensitive: false));

    expect(categoryTextFinder, findsWidgets);
  });

  testWidgets('PostDishPage should contain text with "category" and "allergen"',
      (WidgetTester tester) async {
    final mockAllergenesRepositoryProvider = MockAllergenesRepository();
    await tester.pumpWidget(ProviderScope(
        overrides: [
          allergenesRepositoryProvider
              .overrideWithValue(mockAllergenesRepositoryProvider),
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
              home: PostDishPage()),
        )));

    await tester.pump();

    final allergenTextFinder =
        find.textContaining(RegExp('allergen', caseSensitive: false));

    expect(allergenTextFinder, findsWidgets);
  });
}
