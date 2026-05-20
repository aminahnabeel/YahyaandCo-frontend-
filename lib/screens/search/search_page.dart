import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../journal/journal_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _ctrl = TextEditingController();
  String _q = '';

  final List<String> _accounts = ['Cash', 'Bank Account', 'Sales', 'Receivables'];
  final List<Map<String, String>> _vouchers = [
    {'voucher': 'JV-1', 'date': '2024-05-01', 'desc': 'Opening entry'},
    {'voucher': 'CP-1', 'date': '2024-05-10', 'desc': 'Cash payment'},
    {'voucher': 'CR-1', 'date': '2024-05-12', 'desc': 'Customer receipt'},
  ];
  final List<Map<String, String>> _transactions = [
    {'id': 'T-1', 'title': 'Office Rent'},
    {'id': 'T-2', 'title': 'Client Payment'},
  ];
  final List<Map<String, String>> _notes = [
    {'id': 'N-1', 'title': 'Tax note', 'body': 'Remember GST filing'},
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = appLanguageController.tr;
    final query = _q.toLowerCase();
    final accounts = _accounts.where((a) => a.toLowerCase().contains(query)).toList();
    final vouchers = _vouchers.where((v) => v.values.join(' ').toLowerCase().contains(query)).toList();
    final transactions = _transactions.where((t) => t['title']!.toLowerCase().contains(query)).toList();
    final notes = _notes.where((n) => '${n['title']!} ${n['body'] ?? ''}'.toLowerCase().contains(query)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(tr('Search'))),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _ctrl,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: tr('Search accounts, vouchers, transactions, notes'),
                ),
                onChanged: (v) => setState(() => _q = v),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  if (accounts.isNotEmpty) ...[
                    Text(tr('Accounts'), style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ...accounts.map((a) => ListTile(title: Text(a), leading: const Icon(Icons.account_balance))),
                    const SizedBox(height: 12),
                  ],
                  if (vouchers.isNotEmpty) ...[
                    Text(tr('Vouchers'), style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ...vouchers.map((v) => ListTile(
                          title: Text('${v['voucher']} — ${v['desc']}'),
                          subtitle: Text(v['date'] ?? ''),
                          leading: const Icon(Icons.receipt_long),
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => JournalDetailsPage(entry: v))),
                        )),
                    const SizedBox(height: 12),
                  ],
                  if (transactions.isNotEmpty) ...[
                    Text(tr('Transactions'), style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ...transactions.map((t) => ListTile(title: Text(t['title']!), leading: const Icon(Icons.swap_horiz))),
                    const SizedBox(height: 12),
                  ],
                  if (notes.isNotEmpty) ...[
                    Text(tr('Notes'), style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    ...notes.map((n) => ListTile(title: Text(n['title']!), subtitle: Text(n['body'] ?? ''), leading: const Icon(Icons.note))),
                    const SizedBox(height: 12),
                  ],
                  if (query.isNotEmpty && accounts.isEmpty && vouchers.isEmpty && transactions.isEmpty && notes.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Center(child: Text('${tr('No results for')} "$_q"')),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
