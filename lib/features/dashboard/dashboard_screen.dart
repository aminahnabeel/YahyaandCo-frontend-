import 'package:flutter/material.dart';
import '../customers/customers_screen.dart';
import 'dashboard_stat_detail_screen.dart';
import '../../widgets/hoverable_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int? _selectedStatIndex;

  Widget _statCard(
    BuildContext context,
    String title,
    String amount,
    String change,
    Color accent,
    IconData icon, {
    bool selected = false,
    Color? selectedBackground,
    Color? selectedBorderColor,
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return HoverableCard(
      selected: selected,
      selectedBackground: selectedBackground,
      selectedBorderColor: selectedBorderColor,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Center(child: Icon(icon, color: accent, size: 18)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              amount,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.22),
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
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
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
            backgroundColor: theme.colorScheme.surface,
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
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
    Color color, {
    VoidCallback? onTap,
  }) {
    final theme = Theme.of(context);
    return HoverableCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
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
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // icon tiles removed (not used)

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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

                  // Stats - show as stacked cards with hover/select behavior
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      final singleCol = width < 800;
                      if (singleCol) {
                        return Column(
                          children: [
                            _statCard(
                              context,
                              'Total Receivable',
                              '₹3.6L',
                              '+12% from last month',
                              Colors.green,
                              Icons.currency_rupee,
                              selected: _selectedStatIndex == 0,
                              selectedBackground: Colors.green.withValues(
                                alpha: 0.06,
                              ),
                              selectedBorderColor: Colors.green,
                              onTap: () {
                                setState(() => _selectedStatIndex = 0);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DashboardStatDetailScreen(
                                      title: 'Total Receivable',
                                      amount: '₹3.6L',
                                      change: '+12% from last month',
                                      accentColor: Colors.green,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            _statCard(
                              context,
                              'Total Payable',
                              '₹1.2L',
                              '-5% from last month',
                              Colors.orange,
                              Icons.account_balance_wallet,
                              selected: _selectedStatIndex == 1,
                              selectedBackground: Colors.orange.withValues(
                                alpha: 0.06,
                              ),
                              selectedBorderColor: Colors.orange,
                              onTap: () {
                                setState(() => _selectedStatIndex = 1);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DashboardStatDetailScreen(
                                      title: 'Total Payable',
                                      amount: '₹1.2L',
                                      change: '-5% from last month',
                                      accentColor: Colors.orange,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            _statCard(
                              context,
                              'Pending Amount',
                              '₹3.0L',
                              '+0% from last month',
                              Colors.teal,
                              Icons.hourglass_bottom,
                              selected: _selectedStatIndex == 2,
                              selectedBackground: Colors.teal.withValues(
                                alpha: 0.06,
                              ),
                              selectedBorderColor: Colors.teal,
                              onTap: () {
                                setState(() => _selectedStatIndex = 2);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DashboardStatDetailScreen(
                                      title: 'Pending Amount',
                                      amount: '₹3.0L',
                                      change: '+0% from last month',
                                      accentColor: Colors.teal,
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            _statCard(
                              context,
                              'Overdue',
                              '₹120K',
                              '+8% from last month',
                              Colors.red,
                              Icons.warning_amber_rounded,
                              selected: _selectedStatIndex == 3,
                              selectedBackground: Colors.red.withValues(
                                alpha: 0.06,
                              ),
                              selectedBorderColor: Colors.red,
                              onTap: () {
                                setState(() => _selectedStatIndex = 3);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DashboardStatDetailScreen(
                                      title: 'Overdue',
                                      amount: '₹120K',
                                      change: '+8% from last month',
                                      accentColor: Colors.red,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      }

                      // wide screens: grid
                      return GridView.count(
                        crossAxisCount: 4,
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
                            Icons.currency_rupee,
                            selected: _selectedStatIndex == 0,
                            selectedBackground: Colors.green.withValues(
                              alpha: 0.06,
                            ),
                            selectedBorderColor: Colors.green,
                            onTap: () {
                              setState(() => _selectedStatIndex = 0);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DashboardStatDetailScreen(
                                    title: 'Total Receivable',
                                    amount: '₹3.6L',
                                    change: '+12% from last month',
                                    accentColor: Colors.green,
                                  ),
                                ),
                              );
                            },
                          ),
                          _statCard(
                            context,
                            'Total Payable',
                            '₹1.2L',
                            '-5% from last month',
                            Colors.orange,
                            Icons.account_balance_wallet,
                            selected: _selectedStatIndex == 1,
                            selectedBackground: Colors.orange.withValues(
                              alpha: 0.06,
                            ),
                            selectedBorderColor: Colors.orange,
                            onTap: () {
                              setState(() => _selectedStatIndex = 1);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DashboardStatDetailScreen(
                                    title: 'Total Payable',
                                    amount: '₹1.2L',
                                    change: '-5% from last month',
                                    accentColor: Colors.orange,
                                  ),
                                ),
                              );
                            },
                          ),
                          _statCard(
                            context,
                            'Pending Amount',
                            '₹3.0L',
                            '+0% from last month',
                            Colors.teal,
                            Icons.hourglass_bottom,
                            selected: _selectedStatIndex == 2,
                            selectedBackground: Colors.teal.withValues(
                              alpha: 0.06,
                            ),
                            selectedBorderColor: Colors.teal,
                            onTap: () {
                              setState(() => _selectedStatIndex = 2);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DashboardStatDetailScreen(
                                    title: 'Pending Amount',
                                    amount: '₹3.0L',
                                    change: '+0% from last month',
                                    accentColor: Colors.teal,
                                  ),
                                ),
                              );
                            },
                          ),
                          _statCard(
                            context,
                            'Overdue',
                            '₹120K',
                            '+8% from last month',
                            Colors.red,
                            Icons.warning_amber_rounded,
                            selected: _selectedStatIndex == 3,
                            selectedBackground: Colors.red.withValues(
                              alpha: 0.06,
                            ),
                            selectedBorderColor: Colors.red,
                            onTap: () {
                              setState(() => _selectedStatIndex = 3);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => DashboardStatDetailScreen(
                                    title: 'Overdue',
                                    amount: '₹120K',
                                    change: '+8% from last month',
                                    accentColor: Colors.red,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
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
                  // Feature tiles removed (reference UI)
                  SizedBox.shrink(),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final maxW = constraints.maxWidth;
                      final cardGap = maxW < 640 ? 8.0 : 12.0;
                      final cardWidth = (maxW - cardGap) / 2;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            fit: FlexFit.loose,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: cardWidth,
                                maxWidth: cardWidth,
                              ),
                              child: _featureCard(
                                context,
                                'Add New Customer',
                                'Start tracking with new business relationships',
                                Icons.person_add,
                                Colors.green,
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => const CustomersScreen(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: cardGap),
                          Flexible(
                            fit: FlexFit.loose,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: cardWidth,
                                maxWidth: cardWidth,
                              ),
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
