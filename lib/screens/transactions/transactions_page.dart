import 'package:flutter/material.dart';
import '../starting/language/app_language.dart';
import 'add_transaction.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final TextEditingController _searchController = TextEditingController();
  int _filter = 0; // 0=All,1=Credit,2=Debit

  final List<Map<String, String>> _transactions = [
    {
      'title': 'Office Rent',
      'date': 'Today',
      'amount': '-₹15,000',
      'type': 'debit',
    },
    {
      'title': 'Client Payment',
      'date': 'Today',
      'amount': '+₹42,500',
      'type': 'credit',
    },
    {
      'title': 'Utilities',
      'date': 'Yesterday',
      'amount': '-₹3,200',
      'type': 'debit',
    },
    {
      'title': 'Sales Revenue',
      'date': 'Yesterday',
      'amount': '+₹28,900',
      'type': 'credit',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredTransactions {
    final q = _searchController.text.trim().toLowerCase();
    return _transactions.where((t) {
      final title = t['title']!.toLowerCase();
      final type = t['type']!;
      if (_filter == 1 && type != 'credit') return false;
      if (_filter == 2 && type != 'debit') return false;
      if (q.isEmpty) return true;
      return title.contains(q) || (t['date']!.toLowerCase().contains(q));
    }).toList();
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

  Widget _transactionTile(
    BuildContext context,
    Map<String, String> t,
    AppStrings strings,
  ) {
    final credit = t['type'] == 'credit';
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          _localizeTxText(t['title']!),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        subtitle: Text(
          _localizeTxText(t['date']!),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Text(
          t['amount']!,
          style: TextStyle(
            color: credit ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () {},
      ),
    );
  }

  Future<void> _showEditDialog(int index) async {
    final t = _transactions[index];
    final routeResult = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(
        builder: (_) => AddTransactionPage(initialData: Map<String, dynamic>.from(t)),
      ),
    );
    if (routeResult != null) {
      // Map returned -> update transaction
      setState(() {
        final amount = routeResult['amount']?.toString() ?? t['amount']!;
        final type = (routeResult['type']?.toString() ?? t['type']!);
        _transactions[index] = {
          'title': routeResult['title']?.toString() ?? t['title']!,
          'date': _dateLabelFromIso(routeResult['date']?.toString()),
          'amount': _formatAmount(amount, type),
          'type': type,
        };
      });
    }
  }

  Future<void> _deleteTransaction(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() => _transactions.removeAt(index));
    }
  }

  Future<void> _showAddDialog() async {
    final routeResult = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (_) => const AddTransactionPage()),
    );
    if (routeResult != null) {
      setState(() {
        final amount = routeResult['amount']?.toString() ?? '+0.00';
        final type = (routeResult['type']?.toString() ?? 'debit');
        _transactions.insert(0, {
          'title': routeResult['title']?.toString() ?? 'New Transaction',
          'date': _dateLabelFromIso(routeResult['date']?.toString()),
          'amount': _formatAmount(amount, type),
          'type': type,
        });
      });
    }
  }

  String _dateLabelFromIso(String? iso) {
    if (iso == null) return 'Today';
    try {
      final d = DateTime.parse(iso);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final od = DateTime(d.year, d.month, d.day);
      final diff = today.difference(od).inDays;
      if (diff == 0) return 'Today';
      if (diff == 1) return 'Yesterday';
      return '${od.day}/${od.month}/${od.year}';
    } catch (_) {
      return iso;
    }
  }

  String _formatAmount(String amount, String type) {
    var a = amount.trim();
    if (a.isEmpty) a = '0.00';
    if (!a.startsWith('+') && !a.startsWith('-')) {
      a = (type == 'credit' ? '+' : '-') + a;
    }
    return a;
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
                child: ListView.builder(
                  itemCount: _filteredTransactions.length,
                  itemBuilder: (ctx, i) {
                    final t = _filteredTransactions[i];
                    // need original index in _transactions to allow delete/edit
                    final originalIndex = _transactions.indexOf(t);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(
                          _localizeTxText(t['title']!),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          _localizeTxText(t['date']!),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              t['amount']!,
                              style: TextStyle(
                                color: (t['type'] == 'credit') ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.error,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            PopupMenuButton<String>(
                              onSelected: (v) async {
                                if (v == 'edit') await _showEditDialog(originalIndex);
                                if (v == 'delete') await _deleteTransaction(originalIndex);
                              },
                              itemBuilder: (_) => [
                                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                                const PopupMenuItem(value: 'delete', child: Text('Delete')),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
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
