import 'dart:js';

import 'package:chefapp/Domain/allergene_service.dart';
import 'package:chefapp/Domain/dish_of_the_day_model.dart';
import 'package:chefapp/Domain/Model/locale.dart';
import 'package:chefapp/UI/pages/login_page.dart';
import 'package:chefapp/UI/pages/splash_page.dart';
import 'package:chefapp/Utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DishOfTheDayModel(database: _supabase),
    ),
    ChangeNotifierProvider(
        create: (context) => AllergeneService(database: _supabase))
  ], child: const MyApp()));
}

final _supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp(
            title: 'Chef App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Color.fromARGB(255, 180, 14, 39)),
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeModel.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (_) => SplashPage(database: _supabase),
              '/login': (_) => LoginPage(database: _supabase),
            }),
      ),
    );
  }
}
