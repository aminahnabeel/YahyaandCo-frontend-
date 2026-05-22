import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import 'payment_reminder_controller.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool _emailEnabled = true;
  bool _smsEnabled = false;
  bool _whatsappEnabled = false;
  int _selectedTabIndex = 0;

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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
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
                      style: theme.textTheme.titleMedium?.copyWith(
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
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john@example.com',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertOptionTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: value
                ? theme.colorScheme.primary.withValues(alpha: 0.15)
                : theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
          child: Icon(
            icon,
            color: value ? theme.colorScheme.primary : theme.colorScheme.outline,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: value ? theme.colorScheme.primary : null,
          ),
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

  Widget _emptyState(BuildContext context, String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 64,
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              text,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
            ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.statusLabel,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.business_outlined,
                    size: 16, color: theme.colorScheme.outline),
                const SizedBox(width: 8),
                Text(
                  item.account,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today_outlined,
                    size: 16, color: theme.colorScheme.outline),
                const SizedBox(width: 8),
                Text(
                  'Due: ${item.dueDate.day}/${item.dueDate.month}/${item.dueDate.year}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
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
                OutlinedButton(
                  onPressed: () => togglePaymentReminderCompletion(
                    item.id,
                    !item.isCompleted,
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    item.isCompleted ? 'Mark pending' : 'Mark completed',
                    style: const TextStyle(fontSize: 12),
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: ValueListenableBuilder<List<PaymentReminder>>(
          valueListenable: paymentReminderController,
          builder: (context, items, _) {
            final pending = items.where((item) => item.isPending).length;
            final overdue = items.where((item) => item.isOverdue).length;
            final completed = items.where((item) => item.isCompleted).length;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reminders',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // PROFILE CARD
                    _buildProfileCard(context),

                    // SUMMARY CARDS
                    Row(
                      children: [
                        _summaryCard(
                          context,
                          'Pending',
                          pending,
                          Colors.orange,
                        ),
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
                    const SizedBox(height: 24),

                    // ALERT PREFERENCES
                    Text(
                      'Alert Preferences',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Receive reminders via your preferred channels',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.7),
                          ),
                    ),
                    const SizedBox(height: 12),

                    _buildAlertOptionTile(
                      context: context,
                      icon: Icons.email_outlined,
                      title: 'Email Alerts',
                      value: _emailEnabled,
                      onChanged: (value) {
                        setState(() => _emailEnabled = value);
                      },
                    ),
                    const SizedBox(height: 8),

                    _buildAlertOptionTile(
                      context: context,
                      icon: Icons.sms_outlined,
                      title: 'SMS Alerts',
                      value: _smsEnabled,
                      onChanged: (value) {
                        setState(() => _smsEnabled = value);
                      },
                    ),
                    const SizedBox(height: 8),

                    _buildAlertOptionTile(
                      context: context,
                      icon: Icons.chat_bubble_outline,
                      title: 'WhatsApp Alerts',
                      value: _whatsappEnabled,
                      onChanged: (value) {
                        setState(() => _whatsappEnabled = value);
                      },
                    ),
                    const SizedBox(height: 24),

                    // REMINDERS LIST HEADER
                    Text(
                      'Your Reminders',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),

                    // TABS
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          _buildTabButton(
                            context: context,
                            label: 'Pending',
                            index: 0,
                            isSelected: _selectedTabIndex == 0,
                            onTap: () =>
                                setState(() => _selectedTabIndex = 0),
                          ),
                          _buildTabButton(
                            context: context,
                            label: 'Overdue',
                            index: 1,
                            isSelected: _selectedTabIndex == 1,
                            onTap: () =>
                                setState(() => _selectedTabIndex = 1),
                          ),
                          _buildTabButton(
                            context: context,
                            label: 'Completed',
                            index: 2,
                            isSelected: _selectedTabIndex == 2,
                            onTap: () =>
                                setState(() => _selectedTabIndex = 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // REMINDERS LIST
                    ..._buildRemindersList(context, items),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required BuildContext context,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRemindersList(
    BuildContext context,
    List<PaymentReminder> items,
  ) {
    final filtered = _filterItems(items, _selectedTabIndex);

    if (filtered.isEmpty) {
      return [
        _emptyState(
          context,
          _selectedTabIndex == 0
              ? 'No pending reminders yet.'
              : _selectedTabIndex == 1
                  ? 'No overdue reminders.'
                  : 'No completed reminders yet.',
        ),
      ];
    }

    return filtered.map((item) => _buildItem(context, item)).toList();
  }
}
