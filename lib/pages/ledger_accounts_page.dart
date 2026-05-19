import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../theme.dart';
import 'ledger_report_page.dart';

class LedgerAccountsPage extends StatefulWidget {
  const LedgerAccountsPage({super.key});

  @override
  State<LedgerAccountsPage> createState() => _LedgerAccountsPageState();
}

class _LedgerAccountsPageState extends State<LedgerAccountsPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _accounts = [
    {'name': 'Bank of India - Current A/C', 'code': 'BI-001', 'amount': '₹1,45,000', 'type': 'Bank'},
    {'name': 'HDFC Bank - Savings', 'code': 'HB-001', 'amount': '₹89,500', 'type': 'Bank'},
    {'name': 'Cash in Hand', 'code': 'CASH-001', 'amount': '₹45,200', 'type': 'Cash'},
    {'name': 'ABC Corporation - Receivable', 'code': 'AR-001', 'amount': '₹1,25,000', 'type': 'Customer'},
    {'name': 'XYZ Suppliers - Payable', 'code': 'AP-001', 'amount': '-₹89,300', 'type': 'Supplier'},
    {'name': 'Office Equipment', 'code': 'ASSET-001', 'amount': '₹2,50,000', 'type': 'Asset'},
  ];

  List<Map<String, dynamic>> get _filtered {
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) return _accounts;
    return _accounts.where((a) => (a['name'] as String).toLowerCase().contains(q) || (a['code'] as String).toLowerCase().contains(q)).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Ledger Accounts', onBackPressed: () => Navigator.of(context).pop(), showTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Search account name or code...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (ctx, i) {
                    final a = _filtered[i];
                    final positive = !(a['amount'] as String).startsWith('-');
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        leading: CircleAvatar(backgroundColor: theme.colorScheme.primary.withOpacity(0.12), child: const Icon(Icons.account_balance)),
                        title: Text(a['name'] as String, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                        subtitle: Text(a['code'] as String, style: theme.textTheme.bodySmall),
                        trailing: Text(a['amount'] as String, style: TextStyle(color: positive ? AppTheme.success : theme.colorScheme.error, fontWeight: FontWeight.w700)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => LedgerReportPage(accountName: a['name'] as String, accountCode: a['code'] as String)));
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
