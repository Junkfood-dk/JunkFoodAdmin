import 'package:chefapp/UI/pages/home_page.dart';
import 'package:chefapp/UI/Controllers/authentication_controller.dart';
import 'package:chefapp/UI/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationControllerProvider);

    return authState.when(
      data: (value) {
        value.listen((data) {
          final session = data.session;
          if (session != null) {
            // User is authenticated, navigate to HomePage
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
          } else {
            // User is not authenticated, navigate to LoginPage
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ));
          }
        });
        return const SizedBox(); // Placeholder widget, not used
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
