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
  bool _isSaving = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Profile & Alerts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROFILE SECTION
              _buildProfileCard(context),
              const SizedBox(height: 32),

              // ALERT PREFERENCES SECTION
              Text(
                'Alert Preferences',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose how you want to receive alerts and reminders',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 16),

              // ALERT OPTIONS
              _buildAlertOption(
                context: context,
                icon: Icons.email_outlined,
                title: 'Email Alerts',
                description: 'Receive alerts via email',
                value: _emailEnabled,
                onChanged: (value) {
                  setState(() => _emailEnabled = value);
                },
              ),
              const SizedBox(height: 12),

              _buildAlertOption(
                context: context,
                icon: Icons.sms_outlined,
                title: 'SMS Alerts',
                description: 'Receive alerts via SMS',
                value: _smsEnabled,
                onChanged: (value) {
                  setState(() => _smsEnabled = value);
                },
              ),
              const SizedBox(height: 12),

              _buildAlertOption(
                context: context,
                icon: Icons.chat_bubble_outline,
                title: 'WhatsApp Alerts',
                description: 'Receive alerts via WhatsApp',
                value: _whatsappEnabled,
                onChanged: (value) {
                  setState(() => _whatsappEnabled = value);
                },
              ),
              const SizedBox(height: 24),

              // INFO CARD
              _buildInfoCard(context),
              const SizedBox(height: 24),

              // TEST ALERT SECTION
              Text(
                'Test Alerts',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),

              _buildTestAlertButton(
                context: context,
                icon: Icons.email_outlined,
                label: 'Send Test Email',
                enabled: _emailEnabled,
                onPressed: () => _sendTestAlert('Email'),
              ),
              const SizedBox(height: 10),

              _buildTestAlertButton(
                context: context,
                icon: Icons.sms_outlined,
                label: 'Send Test SMS',
                enabled: _smsEnabled,
                onPressed: () => _sendTestAlert('SMS'),
              ),
              const SizedBox(height: 10),

              _buildTestAlertButton(
                context: context,
                icon: Icons.chat_bubble_outline,
                label: 'Send Test WhatsApp',
                enabled: _whatsappEnabled,
                onPressed: () => _sendTestAlert('WhatsApp'),
              ),
              const SizedBox(height: 32),

              // SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: _isSaving ? null : _savePreferences,
                  child: _isSaving
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.onPrimary,
                            ),
                            strokeWidth: 2.5,
                          ),
                        )
                      : Text(
                          'Save Preferences',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'JD',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john@example.com',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            _buildProfileDetail(
              context: context,
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: '+92 300 1234567',
            ),
            const SizedBox(height: 12),
            _buildProfileDetail(
              context: context,
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'john@example.com',
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit Profile'),
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetail({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlertOption({
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
          color: value
              ? theme.colorScheme.primary.withValues(alpha: 0.3)
              : theme.colorScheme.outline.withValues(alpha: 0.1),
          width: 1.5,
        ),
      ),
      elevation: 0,
      color: value
          ? theme.colorScheme.primary.withValues(alpha: 0.08)
          : theme.colorScheme.surface,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value
                ? theme.colorScheme.primary.withValues(alpha: 0.15)
                : theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
          child: Icon(
            icon,
            color: value ? theme.colorScheme.primary : theme.colorScheme.outline,
            size: 24,
          ),
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
        trailing: Switch.adaptive(
          value: value,
          onChanged: (val) => onChanged(val),
          activeColor: theme.colorScheme.primary,
        ),
        onTap: () => onChanged(!value),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: theme.colorScheme.primary.withValues(alpha: 0.08),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'How Alerts Work',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoBullet(
              context: context,
              text: 'Multiple channels can be selected simultaneously',
            ),
            const SizedBox(height: 8),
            _buildInfoBullet(
              context: context,
              text: 'Alerts will be sent via all selected channels',
            ),
            const SizedBox(height: 8),
            _buildInfoBullet(
              context: context,
              text: 'WhatsApp alerts require phone number with WhatsApp',
            ),
            const SizedBox(height: 8),
            _buildInfoBullet(
              context: context,
              text: 'Email and SMS are independent channels',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBullet({
    required BuildContext context,
    required String text,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodySmall?.copyWith(
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTestAlertButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onPressed,
  }) {
    final theme = Theme.of(context);
    return OutlinedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(label),
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor:
            enabled ? theme.colorScheme.primary : theme.colorScheme.outline,
        side: BorderSide(
          color: enabled
              ? theme.colorScheme.primary.withValues(alpha: 0.5)
              : theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  void _sendTestAlert(String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Test $type alert sent successfully!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _savePreferences() {
    if (!_emailEnabled && !_smsEnabled && !_whatsappEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select at least one alert method'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    setState(() => _isSaving = true);

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isSaving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Alert preferences saved successfully!'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) Navigator.pop(context);
        });
      }
    });
  }
}
