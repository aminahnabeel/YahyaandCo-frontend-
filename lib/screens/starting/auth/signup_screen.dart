import 'package:flutter/material.dart';

import '../language/app_language.dart';
import '../../../widgets/appbar.dart';
import 'signin_screen.dart';
import '../../../widgets/button.dart';
import '../../../widgets/custom_text_field.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: CustomAppBar(
        title: strings.emailTitle,
        showTitle: true,
        onBackPressed: () => Navigator.of(context).pop(),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 18),

                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // ICON
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade100,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ================= NAME =================
                      _label(strings.nameLabel),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _nameController,
                        hintText: "", // ❌ removed placeholder text
                      ),

                      const SizedBox(height: 20),

                      // ================= EMAIL =================
                      _label(strings.emailLabel),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "", // ❌ removed
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 20),

                      // ================= PASSWORD =================
                      _label(strings.passwordLabel),
                      const SizedBox(height: 8),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "", // ❌ removed
                        obscureText: true,
                      ),

                      const SizedBox(height: 32),

                      SizedBox(
                        width: double.infinity,
                        child: RoundedPrimaryButton(
                          label: strings.signUp,
                          icon: null,
                          fullWidth: false,
                          height: 52,
                          onPressed: () {},
                        ),
                      ),

                      const SizedBox(height: 22),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            strings.alreadyHaveAccount,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => const LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              strings.signIn,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}