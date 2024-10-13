import 'package:chefapp/UI/Controllers/authentication_controller.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:chefapp/UI/Widgets/logo_image.dart';
import 'package:chefapp/Utilities/widgets/gradiant_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chefapp/UI/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailTextController = useTextEditingController();
    var passwordTextController = useTextEditingController();
    var isLoading = useState(false);

    Future<void> signIn() async {
      try {
        await ref.watch(authenticationControllerProvider.notifier).signIn(
              emailTextController.text,
              passwordTextController.text,
            );
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.signInSuccessful)),
        );
        emailTextController.clear();
        passwordTextController.clear();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()));
      } on AuthApiException catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${AppLocalizations.of(context)!.signInError}: ${error.message}",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    )),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.signInTitle),
          actions: const [LanguageDropdownWidget()]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Form(
            child: SizedBox(
              width: 300.0,
              child: Column(
                children: [
                  const LogoImage(),
                  Text(AppLocalizations.of(context)!.signInText),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: emailTextController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 18),
                  TextFormField(
                    controller: passwordTextController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => signIn(),
                  ),
                  const SizedBox(height: 18),
                  GradiantButton(
                    onPressed: isLoading.value ? null : signIn,
                    child: Text(isLoading.value ? 'Loading' : 'Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
