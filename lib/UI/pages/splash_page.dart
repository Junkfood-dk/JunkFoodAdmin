import 'package:chefapp/UI/Widgets/logo_image.dart';
import 'package:chefapp/UI/pages/home_page.dart';
import 'package:chefapp/UI/Controllers/authentication_controller.dart';
import 'package:chefapp/UI/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authenticationControllerProvider);

    return authState.when(
      data: (value) {
        value.listen((data) {
          if (!context.mounted) return;
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
        // Placeholder widget, not used
        return const SizedBox.shrink();
      },
      loading: () {
        // TODO: Loading is never called...
        return const Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              LogoImage(),
            ],
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
