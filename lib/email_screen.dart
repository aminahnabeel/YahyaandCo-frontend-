import 'package:flutter/material.dart';

import 'app_language.dart';
import 'widgets/appbar.dart';
import 'widgets/button.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: CustomAppBar(
        showTitle: false,
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.emailTitle,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F1724),
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 36),
                  // Email Input Field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _emailController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: strings.emailPlaceholder,
                        hintStyle: const TextStyle(color: Color(0xFF9EA9B2)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Password Input Field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: strings.passwordPlaceholder,
                        hintStyle: const TextStyle(color: Color(0xFF9EA9B2)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  // Next Button (styled like language selector)
                  SafeArea(
                    top: false,
                    child: RoundedPrimaryButton(
                      label: 'Sign up',
                      icon: null,
                      fullWidth: false,
                      height: 52,
                      onPressed: () {
                        // Handle next action
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Centered Sign In Link
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          strings.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF475467),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            // Navigate to sign in
                          },
                          child: Text(
                            strings.signIn,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
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
