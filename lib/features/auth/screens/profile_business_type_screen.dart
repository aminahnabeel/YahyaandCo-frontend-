import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../dashboard/dashboard_screen.dart';

class BusinessTypeScreen extends StatefulWidget {
  const BusinessTypeScreen({super.key});

  @override
  State<BusinessTypeScreen> createState() => _BusinessTypeScreenState();
}

class _BusinessTypeScreenState extends State<BusinessTypeScreen> {
  int? _selectedIndex;

  void _goToNext() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => DashboardScreen()),
    );
  }

  Widget _cardItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool selected,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cs.outline.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: cs.background,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: cs.onSurface.withOpacity(0.7)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        backgroundColor: cs.background,
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
                children: <Widget>[
                  // progress bars
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < 5; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          width: 40,
                          height: 8,
                          decoration: BoxDecoration(
                            color: i == 0
                                ? AppColors.primary
                                : cs.background.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: cs.outline.withOpacity(0.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Welcome to LedgerFlow',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Let's set up your account and get you ready to manage your business finances smartly",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withOpacity(0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  GridView.count(
                    crossAxisCount: isMobile ? 1 : 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: isMobile ? 3.8 : 3.2,
                    children: <Widget>[
                      _cardItem(
                        context,
                        Icons.show_chart_rounded,
                        'Track Financials',
                        'Monitor your receivables and payables in real-time',
                        false,
                      ),
                      _cardItem(
                        context,
                        Icons.notifications_active_rounded,
                        'Smart Reminders',
                        'Send automated WhatsApp and email reminders',
                        false,
                      ),
                      _cardItem(
                        context,
                        Icons.insights_rounded,
                        'AI Insights',
                        'Get actionable business intelligence',
                        false,
                      ),
                      _cardItem(
                        context,
                        Icons.group_rounded,
                        'Manage Customers',
                        'Organize and track all your business relationships',
                        false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Center(
                    child: SizedBox(
                      width: isMobile ? 240 : 160,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: _goToNext,
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
