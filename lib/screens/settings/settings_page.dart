import 'package:flutter/material.dart';
import '../theme_controller.dart';
import '../login_screen.dart';
import '../widgets/button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _twoFactor = false;

  void _themeListener() {
    final isDark = themeModeController.value == ThemeMode.dark;
    if (mounted) setState(() => _darkMode = isDark);
  }

  @override
  void initState() {
    super.initState();
    _darkMode = themeModeController.value == ThemeMode.dark;
    themeModeController.addListener(_themeListener);
  }

  @override
  void dispose() {
    themeModeController.removeListener(_themeListener);
    super.dispose();
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
    child: Text(
      text.toUpperCase(),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _tile({
    required Widget leading,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: leading,
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        subtitle: subtitle == null
            ? null
            : Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 24, child: Text('JD')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'john@example.com',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _sectionTitle('Preferences'),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SwitchListTile.adaptive(
                  secondary: const SizedBox(width: 36),
                  title: Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: _notifications,
                  onChanged: (v) => setState(() => _notifications = v),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SwitchListTile.adaptive(
                  secondary: const SizedBox(width: 36),
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: _darkMode,
                  onChanged: (v) {
                    toggleDarkMode(v);
                    setState(() => _darkMode = v);
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SwitchListTile.adaptive(
                  secondary: const SizedBox(width: 36),
                  title: Text(
                    'Two-Factor Auth',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: _twoFactor,
                  onChanged: (v) => setState(() => _twoFactor = v),
                  activeColor: Theme.of(context).colorScheme.primary,
                ),
              ),

              _sectionTitle('Account'),
              _tile(
                leading: Icon(
                  Icons.lock_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'Change Password',
                onTap: () {},
              ),
              _tile(
                leading: Icon(
                  Icons.email_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'Email Preferences',
                onTap: () {},
              ),
              _tile(
                leading: Icon(
                  Icons.business,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'Manage Businesses',
                onTap: () {},
              ),

              _sectionTitle('Information'),
              _tile(
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'About Ledger App',
                onTap: () {},
              ),
              _tile(
                leading: Icon(
                  Icons.article_outlined,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              _tile(
                leading: Icon(
                  Icons.lock,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: 'Privacy Policy',
                onTap: () {},
              ),

              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: RoundedPrimaryButton(
                  label: 'Logout',
                  fullWidth: true,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
