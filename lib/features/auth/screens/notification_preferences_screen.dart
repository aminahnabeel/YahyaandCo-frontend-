import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'connect_bank_screen.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  int _selected = 2; // default selected: SMS

  void _onSelect(int idx) => setState(() => _selected = idx);

  void _onContinue() {
    if (!mounted) return;
    if (!mounted) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const ConnectBankScreen()));
  }

  Widget _prefCard({
    required BuildContext context,
    required int idx,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final bool selected = _selected == idx;

    return GestureDetector(
      onTap: () => _onSelect(idx),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.06)
              : cs.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : cs.outline.withValues(alpha: 0.6),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withValues(alpha: 0.14)
                    : cs.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: selected
                    ? AppColors.primary
                    : cs.onSurface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: AppColors.primary)
            else
              const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        elevation: 0,
        backgroundColor: cs.surface,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 18 : 28,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 960),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 5; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == 2
                                ? AppColors.primary
                                : cs.surface.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: cs.outline.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Notification Preferences',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'How would you like to receive payment reminders?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _prefCard(
                    context: context,
                    idx: 0,
                    icon: Icons.chat_bubble_outline,
                    title: 'WhatsApp',
                    subtitle: 'Get reminders and updates on WhatsApp',
                  ),
                  const SizedBox(height: 12),
                  _prefCard(
                    context: context,
                    idx: 1,
                    icon: Icons.email_outlined,
                    title: 'Email',
                    subtitle: 'Receive detailed reports and notifications',
                  ),
                  const SizedBox(height: 12),
                  _prefCard(
                    context: context,
                    idx: 2,
                    icon: Icons.phone_rounded,
                    title: 'SMS',
                    subtitle: 'Quick text message alerts',
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: SizedBox(
                      width: isMobile ? 240 : 160,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: _onContinue,
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text(
                          'Continue',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
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
