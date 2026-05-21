import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import 'payment_reminder_controller.dart';

class ReminderScreen extends StatelessWidget {
  const ReminderScreen({super.key});

  List<PaymentReminder> _filterItems(
    List<PaymentReminder> items,
    int index,
  ) {
    switch (index) {
      case 1:
        return items.where((item) => item.isOverdue).toList();
      case 2:
        return items.where((item) => item.isCompleted).toList();
      default:
        return items.where((item) => item.isPending).toList();
    }
  }

  Widget _summaryCard(
    BuildContext context,
    String label,
    int value,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.18)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 58,
              color: Theme.of(context).hintColor,
            ),
            const SizedBox(height: 12),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, PaymentReminder item) {
    final theme = Theme.of(context);
    final color = item.isCompleted
        ? theme.colorScheme.primary
        : item.isOverdue
            ? theme.colorScheme.error
            : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    item.statusLabel,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(item.account, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 6),
            Text(
              'Due: ${item.dueDate.day}/${item.dueDate.month}/${item.dueDate.year}',
            ),
            const SizedBox(height: 6),
            Text('Method: ${item.paymentMethod}'),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  item.amountLabel,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: item.isDebit
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => togglePaymentReminderCompletion(
                    item.id,
                    !item.isCompleted,
                  ),
                  child: Text(
                    item.isCompleted ? 'Mark pending' : 'Mark completed',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<List<PaymentReminder>>(
          valueListenable: paymentReminderController,
          builder: (context, items, _) {
            final pending = items.where((item) => item.isPending).length;
            final overdue = items.where((item) => item.isOverdue).length;
            final completed = items.where((item) => item.isCompleted).length;

            return DefaultTabController(
              length: 3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLanguageController.tr('Reminders'),
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _summaryCard(context, 'Pending', pending, Colors.orange),
                        const SizedBox(width: 10),
                        _summaryCard(
                          context,
                          'Overdue',
                          overdue,
                          Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(width: 10),
                        _summaryCard(
                          context,
                          'Completed',
                          completed,
                          Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TabBar(
                      labelColor: Theme.of(context).colorScheme.primary,
                      tabs: const [
                        Tab(text: 'Pending'),
                        Tab(text: 'Overdue'),
                        Tab(text: 'Completed'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: TabBarView(
                        children: List.generate(3, (tabIndex) {
                          final filtered = _filterItems(items, tabIndex);
                          if (filtered.isEmpty) {
                            return _emptyState(
                              context,
                              tabIndex == 0
                                  ? 'No pending reminders yet.'
                                  : tabIndex == 1
                                      ? 'No overdue reminders.'
                                      : 'No completed reminders yet.',
                            );
                          }
                          return ListView.builder(
                            itemCount: filtered.length,
                            itemBuilder: (context, index) =>
                                _buildItem(context, filtered[index]),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
