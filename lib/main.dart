import 'dart:js';

import 'package:chefapp/model/allergene_service.dart';
import 'package:chefapp/model/dish_of_the_day_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chefapp/pages/login_page.dart';
import 'package:chefapp/pages/splash_page.dart';
import 'package:chefapp/pages/add_menu.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:chefapp/Constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'model/locale.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
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
