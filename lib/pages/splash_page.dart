import 'package:chefapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:chefapp/main.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SplashPage extends StatefulWidget {
  final SupabaseClient database;
  const SplashPage({super.key, required this.database});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = widget.database.auth.currentSession;
    if (session != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
