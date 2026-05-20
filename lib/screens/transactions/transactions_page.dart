import 'package:flutter/material.dart';
import '../starting/language/app_language.dart';

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

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;
    return SafeArea(
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
                  return _transactionTile(ctx, t, strings);
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
