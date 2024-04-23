import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/UI/pages/post_dish_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('PostDishPage should display the camera button',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
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
          home: const PostDishPage()),
    )));

    final cameraButtonFinder =
        find.widgetWithText(OutlinedButton, 'Add Picture From Camera');

    expect(cameraButtonFinder, findsOneWidget);
  });
}
