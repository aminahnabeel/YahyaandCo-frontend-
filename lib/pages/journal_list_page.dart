import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import 'journal_details_page.dart';

class JournalListPage extends StatelessWidget {
  const JournalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = [
      {'voucher': 'JV-1', 'date': '2024-05-01', 'desc': 'Opening entry', 'amount': '50,000'},
      {'voucher': 'CP-1', 'date': '2024-05-10', 'desc': 'Cash payment', 'amount': '20,000'},
      {'voucher': 'CR-1', 'date': '2024-05-12', 'desc': 'Customer receipt', 'amount': '10,000'},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Journal',
        onBackPressed: () => Navigator.of(context).pop(),
        showTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: rows.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (ctx, i) {
            final r = rows[i];
            return ListTile(
              title: Text('${r['voucher']} — ${r['desc']}', style: theme.textTheme.titleMedium),
              subtitle: Text(r['date']!),
              trailing: Text(r['amount']!, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700)),
              onTap: () => Navigator.of(ctx).push(MaterialPageRoute(builder: (_) => JournalDetailsPage(entry: r))),
            );
          },
        ),
      ),
    );
  }
}
