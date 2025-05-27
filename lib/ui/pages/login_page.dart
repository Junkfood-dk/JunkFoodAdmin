import 'package:chefapp/ui/controllers/authentication_controller.dart';
import 'package:chefapp/ui/widgets/language_dropdown_widget.dart';
import 'package:chefapp/ui/widgets/logo_image.dart';
import 'package:chefapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:chefapp/utilities/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chefapp/ui/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    try {
      setState(() {
        isLoading = true;
      });

      await ref.read(authenticationControllerProvider.notifier).signIn(
            emailTextController.text,
            passwordTextController.text,
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.signInSuccessful),
        ),
      );
      emailTextController.clear();
      passwordTextController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } on AuthApiException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${AppLocalizations.of(context)!.signInError}: ${error.message}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signInTitle),
        actions: const [LanguageDropdownWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoImage(),
                Text(AppLocalizations.of(context)!.signInText),
                const SizedBox(height: 18),
                Center(
                  child: SizedBox(
                    width: 300.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: emailTextController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.emailFieldLabel,
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: passwordTextController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .passwordFieldLabel,
                          ),
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => signIn(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  GradiantButton(
                    onPressed: signIn,
                    child: Text(AppLocalizations.of(context)!.signInButton),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
