import 'package:chefapp/components/language_dropdown_component.dart';
import 'package:chefapp/my_home_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chefapp/model/language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:chefapp/model/locale.dart';

void main() {
  testWidgets('Pop up menu button for language selection exists on Homepage',
      (WidgetTester tester) async {
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
            home: MyHomePage(title: "Chef App"),
          ),
        )));

    //Act
    final appBarFinder = find.byType(AppBar);
    final popupMenuButtonFinder = find.byType(LanguageDropdown);
    final buttonInAppBarFinder =
        find.descendant(of: appBarFinder, matching: popupMenuButtonFinder);

    //Assert
    expect(appBarFinder, findsOneWidget);
    expect(popupMenuButtonFinder, findsOneWidget);
    expect(buttonInAppBarFinder, findsOneWidget);
  });
}