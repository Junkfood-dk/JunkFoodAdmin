import 'package:chefapp/UI/Controllers/authentication_controller.dart';
import 'package:chefapp/UI/Widgets/language_dropdown_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:chefapp/UI/pages/home_page.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var emailTextController = useTextEditingController();
    var passwordTextController = useTextEditingController();
    var isLoading = useState(false);

    Future<void> _signIn() async {
      try {
        await ref.watch(authenticationControllerProvider.notifier).signIn(
          emailTextController.text,
          passwordTextController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(AppLocalizations.of(context)!.signInSuccessful)),
        );
        emailTextController.clear();
        passwordTextController.clear();
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${AppLocalizations.of(context)!.signInError}$error"),
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
        actions: [LanguageDropdownWidget()]
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          Text(AppLocalizations.of(context)!.signInText),
          const SizedBox(height: 18),
          TextFormField(
            controller: emailTextController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: passwordTextController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: isLoading.value ? null : _signIn,
            child: Text(isLoading.value ? 'Loading' : 'Sign In'),
          ),
        ],
      ),
    );
  }
}
