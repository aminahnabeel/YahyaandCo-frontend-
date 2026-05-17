import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _statCard(
    BuildContext context,
    String title,
    String amount,
    String change,
    Color accent,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                change,
                style: theme.textTheme.bodySmall?.copyWith(color: accent),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _insightCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }

  Widget _transactionItem(
    BuildContext context,
    String title,
    String subtitle,
    String amount,
    Color amountColor,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.background,
            child: Text(title[0]),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: theme.textTheme.titleSmall?.copyWith(
              color: amountColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
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
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back! Here\'s your financial overview',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 18),

                  GridView.count(
                    crossAxisCount: isMobile ? 1 : 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.6,
                    children: [
                      _statCard(
                        context,
                        'Total Receivable',
                        '₹3.6L',
                        '+12% from last month',
                        Colors.green,
                      ),
                      _statCard(
                        context,
                        'Total Payable',
                        '₹1.2L',
                        '-5% from last month',
                        Colors.orange,
                      ),
                      _statCard(
                        context,
                        'Pending Amount',
                        '₹3.0L',
                        '+0% from last month',
                        Colors.teal,
                      ),
                      _statCard(
                        context,
                        'Overdue',
                        '₹120K',
                        '+8% from last month',
                        Colors.red,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const SizedBox(height: 6),
                            _insightCard(
                              context,
                              Icons.warning_amber_rounded,
                              'Outstanding Payment: Tech Solutions Inc owes ₹120,000 (30 days overdue)',
                              Colors.red,
                            ),
                            const SizedBox(height: 12),
                            _insightCard(
                              context,
                              Icons.check_circle_outline,
                              'Collection Success: 85% of receivables collected on time this month',
                              Colors.green,
                            ),
                            const SizedBox(height: 12),
                            _insightCard(
                              context,
                              Icons.schedule,
                              'Upcoming Due: ₹24,000 due in next 7 days across 4 customers',
                              Colors.orange,
                            ),
                            const SizedBox(height: 18),
                            Text(
                              'Recent Transactions',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Column(
                              children: [
                                _transactionItem(
                                  context,
                                  'ABC Corporation',
                                  'Invoice for services',
                                  '+₹50K',
                                  Colors.green,
                                ),
                                const SizedBox(height: 8),
                                _transactionItem(
                                  context,
                                  'XYZ Trading Ltd',
                                  'Supplier payment - Raw materials',
                                  '-₹75K',
                                  Colors.orange,
                                ),
                                const SizedBox(height: 8),
                                _transactionItem(
                                  context,
                                  'Tech Solutions Inc',
                                  'Project completion invoice',
                                  '+₹120K',
                                  Colors.green,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // right column removed; feature cards will appear at the bottom
                    ],
                  ),

                  const SizedBox(height: 18),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final maxW = constraints.maxWidth;
                      if (maxW < 640) {
                        return Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: double.infinity),
                              child: _featureCard(
                                context,
                                'Add New Customer',
                                'Start tracking with new business relationships',
                                Icons.person_add,
                                Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: double.infinity),
                              child: _featureCard(
                                context,
                                'Create Reminder',
                                'Set up automated payment reminders',
                                Icons.notifications,
                                Colors.orange,
                              ),
                            ),
                          ],
                        );
                      }

                      final half = (maxW - 12) / 2;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 300, maxWidth: half),
                              child: _featureCard(
                                context,
                                'Add New Customer',
                                'Start tracking with new business relationships',
                                Icons.person_add,
                                Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 300, maxWidth: half),
                              child: _featureCard(
                                context,
                                'Create Reminder',
                                'Set up automated payment reminders',
                                Icons.notifications,
                                Colors.orange,
                              ),
                            ),
                          ),
                        ],
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
