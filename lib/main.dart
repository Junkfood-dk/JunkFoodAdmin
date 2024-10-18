import 'package:chefapp/ui/controllers/authentication_controller.dart';
import 'package:chefapp/ui/controllers/locale_controller.dart';
import 'package:chefapp/utilities/theming/color_theme.dart';
import 'package:chefapp/utilities/theming/text_theming.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chefapp/ui/pages/splash_page.dart';
import 'package:chefapp/utilities/constants.dart';
import 'package:flutter/material.dart';
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
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Skip signing in while debugging
    if (kDebugMode) {
      const username = String.fromEnvironment("USERNAME");
      const password = String.fromEnvironment("PASSWORD");

      if (username.isNotEmpty && password.isNotEmpty) {
        ref.read(authenticationControllerProvider.notifier).signIn(
              username,
              password,
            );
      }
    }

    var locale = ref.watch(localeControllerProvider);
    return MaterialApp(
      title: 'Junkfood Chef App',
      theme: ThemeData(
        colorScheme: colorTheme,
        textTheme: appTextTheme,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
