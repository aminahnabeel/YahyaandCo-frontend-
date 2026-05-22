import 'package:flutter/material.dart';
import '../starting/language/app_language.dart';

class AlertPreferencesPage extends StatefulWidget {
  const AlertPreferencesPage({super.key});

  @override
  State<AlertPreferencesPage> createState() => _AlertPreferencesPageState();
}

class _AlertPreferencesPageState extends State<AlertPreferencesPage> {
  bool _emailEnabled = false;
  bool _smsEnabled = false;
  bool _whatsappEnabled = false;

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alert Preference'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select how you want to send alerts and reminders to customers:',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              _alertOptionCard(
                context: context,
                icon: Icons.email_outlined,
                title: 'Email',
                description: 'Send alerts via email',
                value: _emailEnabled,
                onChanged: (value) {
                  setState(() => _emailEnabled = value);
                },
              ),
              const SizedBox(height: 12),
              _alertOptionCard(
                context: context,
                icon: Icons.sms_outlined,
                title: 'SMS',
                description: 'Send alerts via SMS',
                value: _smsEnabled,
                onChanged: (value) {
                  setState(() => _smsEnabled = value);
                },
              ),
              const SizedBox(height: 12),
              _alertOptionCard(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: 'WhatsApp',
                description: 'Send alerts via WhatsApp',
                value: _whatsappEnabled,
                onChanged: (value) {
                  setState(() => _whatsappEnabled = value);
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  onPressed: _savePreferences,
                  child: Text(
                    'Save Preferences',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _alertOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required bool value,
    required Function(bool) onChanged,
  }) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: value ? theme.colorScheme.primary : Colors.grey[300]!,
          width: value ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: value ? theme.colorScheme.primary : Colors.grey,
          size: 28,
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: value ? theme.colorScheme.primary : null,
          ),
        ),
        subtitle: Text(
          description,
          style: theme.textTheme.bodySmall,
        ),
        trailing: Checkbox.adaptive(
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          activeColor: theme.colorScheme.primary,
        ),
        onTap: () => onChanged(!value),
      ),
    );
  }

  void _savePreferences() {
    if (!_emailEnabled && !_smsEnabled && !_whatsappEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one alert method'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alert preferences saved successfully',
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context);
    });
  }
}
