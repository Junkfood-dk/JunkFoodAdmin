import 'package:chefapp/UI/Controllers/locale_controller.dart';
import 'package:chefapp/Utilities/theming/color_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chefapp/UI/pages/splash_page.dart';
import 'package:chefapp/Utilities/constants.dart';
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

final _supabase = Supabase.instance.client;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var locale = ref.watch(localeControllerProvider);
    return MaterialApp(
      title: 'Chef App',
      theme: ThemeData(
        colorScheme: colorTheme,
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
