import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../reminders/payment_reminder_controller.dart';
import 'add_transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TextEditingController _searchController = TextEditingController();
  int _filter = 0; // 0=All,1=Credit,2=Debit

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _localizeTxText(String text) {
    final s = appLanguageController.strings;
    switch (text) {
      case 'Office Rent':
        return s.officeRent;
      case 'Client Payment':
        return s.clientPayment;
      case 'Utilities':
        return s.utilities;
      case 'Sales Revenue':
        return s.salesRevenue;
      case 'Today':
        return s.today;
      case 'Yesterday':
        return s.yesterday;
      default:
        return appLanguageController.tr(text);
    }
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final current = DateTime(date.year, date.month, date.day);
    final diff = today.difference(current).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    return '${current.day}/${current.month}/${current.year}';
  }

  Future<void> _showAddDialog() async {
    await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (_) => const AddTransactionPage()),
    );
  }

  Future<void> _editTransaction(PaymentReminder item) async {
    await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (_) => AddTransactionPage(initialData: item.toMap())),
    );
  }

  Future<void> _deleteTransaction(PaymentReminder item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      deletePaymentReminder(item.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Text(
                strings.transactionsTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: strings.searchTransactions,
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  PopupMenuButton<int>(
                    icon: const Icon(Icons.filter_list),
                    onSelected: (v) => setState(() => _filter = v),
                    itemBuilder: (_) => [
                      PopupMenuItem(value: 0, child: Text(strings.allFilter)),
                      PopupMenuItem(value: 1, child: Text(strings.creditFilter)),
                      PopupMenuItem(value: 2, child: Text(strings.debitFilter)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ValueListenableBuilder<List<PaymentReminder>>(
                  valueListenable: paymentReminderController,
                  builder: (context, items, _) {
                    final q = _searchController.text.trim().toLowerCase();
                    final filtered = items.where((item) {
                      if (_filter == 1 && item.isDebit) return false;
                      if (_filter == 2 && !item.isDebit) return false;
                      if (q.isEmpty) return true;
                      return item.title.toLowerCase().contains(q) ||
                          item.account.toLowerCase().contains(q) ||
                          item.paymentMethod.toLowerCase().contains(q);
                    }).toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Text(
                          'No transactions found.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (ctx, i) {
                        final item = filtered[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              _localizeTxText(item.title),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            subtitle: Text(
                              '${_localizeTxText(_dateLabel(item.transactionDate))} • ${item.account}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item.amountLabel,
                                  style: TextStyle(
                                    color: item.isDebit
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                PopupMenuButton<String>(
                                  onSelected: (v) async {
                                    if (v == 'edit') {
                                      await _editTransaction(item);
                                    }
                                    if (v == 'delete') {
                                      await _deleteTransaction(item);
                                    }
                                  },
                                  itemBuilder: (_) => [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
