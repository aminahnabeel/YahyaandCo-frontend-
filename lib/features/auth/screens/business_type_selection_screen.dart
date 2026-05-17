import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'notification_preferences_screen.dart';
import '../../../widgets/hoverable_card.dart';

class BusinessTypeSelectionScreen extends StatefulWidget {
  const BusinessTypeSelectionScreen({super.key});

  @override
  State<BusinessTypeSelectionScreen> createState() =>
      _BusinessTypeSelectionScreenState();
}

class _BusinessTypeSelectionScreenState
    extends State<BusinessTypeSelectionScreen> {
  int? _selectedIndex = 0;

  void _onContinue() {
    if (!mounted) return;
    if (!mounted) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const NotificationPreferencesScreen(),
      ),
    );
  }

  Widget _optionCard({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final bool selected = _selectedIndex == index;

    return HoverableCard(
      selected: selected,
      onTap: () => setState(() => _selectedIndex = index),
      child: Padding(
        padding: const EdgeInsets.all(18),
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
                            color: i == 1
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
                    'What type of business do you run?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This helps us customize your experience',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurface.withValues(alpha: 0.72),
                    ),
                  ),
                  const SizedBox(height: 22),
                  GridView.count(
                    crossAxisCount: isMobile ? 1 : 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: isMobile ? 3.8 : 3.6,
                    children: [
                      _optionCard(
                        context: context,
                        index: 0,
                        icon: Icons.precision_manufacturing,
                        title: 'Manufacturing',
                        subtitle: 'Produce and sell goods',
                      ),
                      _optionCard(
                        context: context,
                        index: 1,
                        icon: Icons.swap_horiz,
                        title: 'Trading/Wholesale',
                        subtitle: 'Buy and sell products in bulk',
                      ),
                      _optionCard(
                        context: context,
                        index: 2,
                        icon: Icons.miscellaneous_services,
                        title: 'Services/Consulting',
                        subtitle: 'Offer professional services',
                      ),
                      _optionCard(
                        context: context,
                        index: 3,
                        icon: Icons.more_horiz,
                        title: 'Other',
                        subtitle: 'Any other business type',
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
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
