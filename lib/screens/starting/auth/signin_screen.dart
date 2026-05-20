import 'package:flutter/material.dart';
import '../business_setup/select_business.dart';
import '../language/app_language.dart';
import '../../../widgets/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    strings.signInTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    strings.signInSubtitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 28),
                  TextField(
                    decoration: InputDecoration(
                      labelText: strings.emailLabel,
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: strings.passwordLabel,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  const SizedBox(height: 24),
                  RoundedPrimaryButton(
                    label: appLanguageController.tr('Login'),
                    fullWidth: true,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => const LogoScreen(),
                        ),
                      );
                    },
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
