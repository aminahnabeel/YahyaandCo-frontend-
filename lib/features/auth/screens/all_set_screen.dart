import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../dashboard/dashboard_screen.dart';

class AllSetScreen extends StatelessWidget {
  const AllSetScreen({super.key});

  void _goToDashboard(BuildContext context) {
    if (!Navigator.of(context).mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => DashboardScreen()),
    );
  }

  Widget _featureCard(BuildContext context, String title, String subtitle) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(10),
      ),
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
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
                            color: i == 4
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
                  const SizedBox(height: 26),
                  Center(
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 84,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "You're All Set!",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Your LedgerFlow account is ready. Let's start managing your business finances",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _featureCard(
                          context,
                          'Dashboard',
                          'View your financial overview',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _featureCard(
                          context,
                          'Add Customers',
                          'Build your customer database',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _featureCard(
                          context,
                          'Track Ledger',
                          'Manage receivables & payables',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: SizedBox(
                      width: isMobile ? 240 : 220,
                      height: 48,
                      child: FilledButton.icon(
                        onPressed: () => _goToDashboard(context),
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: const Text(
                          'Go to Dashboard',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
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
