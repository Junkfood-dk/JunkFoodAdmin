import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/my_home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefapp/model/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/model/locale.dart';

void main() {
  test('English is present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'English');

    // Assert
    expect(englishExists, isTrue);
  });

  test('Spanish is not present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'Spanish');

    // Assert
    expect(englishExists, isFalse);
  });

  test('Language object for English (id: 1) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language englishLanguage =
        languages.firstWhere((language) => language.id == 1);

    // Assert
    expect(englishLanguage.name, equals('English'));
  });

  test('Language object for Danish (id: 2) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language danishLanguage =
        languages.firstWhere((language) => language.id == 2);

    // Assert
    expect(danishLanguage.name, equals('Dansk'));
  });

  test('Language object with id 3000 does not exist', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool id3Exists = languages.any((language) => language.id == 3000);

    // Assert
    expect(id3Exists, isFalse);
  });

  testWidgets('Language_dropdown_component contains danish and english options',
    (WidgetTester tester) async {
      
      //Arrange
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => LocaleModel(),
        child: Consumer<LocaleModel>(
          builder: (context, localeModel, child) => MaterialApp(
            title: 'Chef App',
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeModel.locale,
            debugShowCheckedModeBanner: false,
            home: LanguageDropdown(),
          ),
        )));

      //Act

      // Open the language dropdown.
      await tester.tap(find.byType(LanguageDropdown));
      await tester.pumpAndSettle();

      final englishItemFinder = find.text('English');
      final danishItemFinder = find.text('Dansk');

      //Assert
      expect(englishItemFinder, findsOneWidget);
      expect(danishItemFinder, findsOneWidget);
  
  });

//Test if locale changes when language is selected in dropdown-menu
   testWidgets('Language_dropdown_component changes locale when option is pressed',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(ChangeNotifierProvider(
        create: (context) => LocaleModel(),
        child: Consumer<LocaleModel>(
          builder: (context, localeModel, child) => MaterialApp(
            title: 'Chef App',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeModel.locale,
            debugShowCheckedModeBanner: false,
            home: LanguageDropdown(),
          ),
        )));

    //Act
    Locale? initialLocale = Localizations.localeOf(tester.element(find.byType(LanguageDropdown)));

    await tester.tap(find.byType(LanguageDropdown)); // Open the language dropdown.
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dansk'));
    await tester.pumpAndSettle();

    Locale? localeAfterDanishIsPressed = Localizations.localeOf(tester.element(find.byType(LanguageDropdown)));

    await tester.tap(find.byType(LanguageDropdown)); // Open the language dropdown.
    await tester.pumpAndSettle();
    
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
   
    Locale? localeAfterEnglishIsPressed = Localizations.localeOf(tester.element(find.byType(LanguageDropdown)));

    //Assert
    expect(initialLocale, equals(Locale('en')));
    expect(localeAfterDanishIsPressed, equals(Locale('da')));
    expect(localeAfterEnglishIsPressed, equals(Locale('en')));
  });

  
}
