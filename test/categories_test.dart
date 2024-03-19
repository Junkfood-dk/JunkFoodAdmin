import 'package:chefapp/model/category_service.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:chefapp/model/locale.dart';
import 'package:chefapp/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'fakeSupaBase.dart';

void main() {
  testWidgets('PostDishPage should contain text with "category"', (WidgetTester tester) async {
    final fakeSupabaseClient = FakeSupabase();

    final categoryService = CategoryService(database: fakeSupabaseClient);
    final dishOfTheDayModel = DishOfTheDayModel(database: fakeSupabaseClient);
    final localeModel = LocaleModel();

    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryService>(create: (_) => categoryService),
        ChangeNotifierProvider<DishOfTheDayModel>(create: (_) => dishOfTheDayModel),
        ChangeNotifierProvider<LocaleModel>(create: (_) => localeModel),
      ],
      child: const MaterialApp(
        home: PostDishPage(),
        localizationsDelegates: [
          AppLocalizations.delegate, 
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''),
          Locale('da', '')],  
      ),
    ));

    await tester.pumpAndSettle();

    final categoryTextFinder = find.textContaining(RegExp('category', caseSensitive: false));

    expect(categoryTextFinder, findsWidgets);
  });
}