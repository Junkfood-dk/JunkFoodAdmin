import 'package:chefapp/Domain/model/language_model.dart';
import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  test('English is present in language list', () {
    // Arrange
    final List<LanguageModel> languages = LanguageModel.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'English');

    // Assert
    expect(englishExists, isTrue);
  });

  test('Spanish is not present in language list', () {
    // Arrange
    final List<LanguageModel> languages = LanguageModel.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'Spanish');

    // Assert
    expect(englishExists, isFalse);
  });

  test('Language object for English (id: 1) exists', () {
    // Arrange
    final List<LanguageModel> languages = LanguageModel.languageList();

    // Act
    final LanguageModel englishLanguage =
        languages.firstWhere((language) => language.id == 1);

    // Assert
    expect(englishLanguage.name, equals('English'));
  });

  test('Language object for Danish (id: 2) exists', () {
    // Arrange
    final List<LanguageModel> languages = LanguageModel.languageList();

    // Act
    final LanguageModel danishLanguage =
        languages.firstWhere((language) => language.id == 2);

    // Assert
    expect(danishLanguage.name, equals('Dansk'));
  });

  test('Language object with id 3000 does not exist', () {
    // Arrange
    final List<LanguageModel> languages = LanguageModel.languageList();

    // Act
    final bool id3Exists = languages.any((language) => language.id == 3000);

    // Assert
    expect(id3Exists, isFalse);
  });

  testWidgets('Language_dropdown_component contains danish and english options',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(ProviderScope(
      child: MaterialApp(home: LanguageDropdownWidget()),
    ));

    //Act

    // Open the language dropdown.
    await tester.tap(find.byType(LanguageDropdownWidget));
    await tester.pumpAndSettle();

    final englishItemFinder = find.text('English');
    final danishItemFinder = find.text('Dansk');

    //Assert
    expect(englishItemFinder, findsOneWidget);
    expect(danishItemFinder, findsOneWidget);
  });

//Test if locale changes when language is selected in dropdown-menu
  testWidgets(
      'Language_dropdown_component changes locale when option is pressed',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      ProviderScope(
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
            home: const LanguageDropdownWidget()),
      )),
    );

    //Act
    Locale? initialLocale = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    await tester.tap(
        find.byType(LanguageDropdownWidget)); // Open the language dropdown.
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dansk'));
    await tester.pumpAndSettle();

    Locale? localeAfterDanishIsPressed = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    await tester.tap(
        find.byType(LanguageDropdownWidget)); // Open the language dropdown.
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    Locale? localeAfterEnglishIsPressed = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    //Assert
    expect(initialLocale.languageCode, equals('en'));
    expect(localeAfterDanishIsPressed.languageCode, equals('da'));
    expect(localeAfterEnglishIsPressed.languageCode, equals('en'));
  });
}
