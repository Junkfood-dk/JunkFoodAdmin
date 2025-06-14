import 'package:chefapp/data/allergens_repository.dart';
import 'package:chefapp/data/categories_repository.dart';
import 'package:chefapp/ui/pages/post_dish_page.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'muteable_checkbow_widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CategoriesRepository>()])
@GenerateNiceMocks([MockSpec<AllergensRepository>()])
void main() {
  testWidgets('PostDishPage should contain text with "category" and "allergen"',
      (WidgetTester tester) async {
    final mockCategoryRepositoryProvider = MockCategoriesRepository();
    await tester.pumpWidget(
      ProviderScope(
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
            home: PostDishPage(),
          ),
        ),
      ),
    );

    await tester.pump();

    final categoryTextFinder =
        find.textContaining(RegExp('category', caseSensitive: false));

    expect(categoryTextFinder, findsWidgets);
  });

  testWidgets('PostDishPage should contain text with "category" and "allergen"',
      (WidgetTester tester) async {
    final mockAllergenesRepositoryProvider = MockAllergensRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          allergensRepositoryProvider
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
            home: PostDishPage(),
          ),
        ),
      ),
    );

    await tester.pump();

    final allergenTextFinder =
        find.textContaining(RegExp('allergen', caseSensitive: false));

    expect(allergenTextFinder, findsWidgets);
  });
}
