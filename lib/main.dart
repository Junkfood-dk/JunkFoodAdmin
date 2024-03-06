import 'package:chefapp/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chefapp/pages/login_page.dart';
import 'package:chefapp/pages/splash_page.dart';
import 'package:chefapp/pages/add_menu.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:chefapp/Constants.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef App',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 180, 14, 39)),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Chef Starting Application'),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/home': (_) => const MyHomePage(title: "home"),
        '/add': (_) => const AddPage(),    
       },
    );
  }
}
