import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../theme.dart';

class JournalDetailsPage extends StatelessWidget {
  final Map<String, dynamic> entry;
  const JournalDetailsPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lines = [
      {'account': 'Bank Account', 'debit': entry['voucher'] == 'JV-1' ? '50,000' : '', 'credit': ''},
      {'account': 'Sales Revenue', 'debit': '', 'credit': entry['voucher'] == 'JV-1' ? '50,000' : ''},
    ];
    return Scaffold(
      appBar: CustomAppBar(title: 'Journal ${entry['voucher']}', onBackPressed: () => Navigator.of(context).pop(), showTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Voucher: ${entry['voucher']}', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text('Date: ${entry['date']}', style: theme.textTheme.bodySmall),
                    const SizedBox(height: 6),
                    Text('Description: ${entry['desc']}', style: theme.textTheme.bodyMedium),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(children: [
                    Row(children: [
                      Expanded(child: Text('Account', style: theme.textTheme.bodySmall)),
                      SizedBox(width: 120, child: Text('Debit', textAlign: TextAlign.right, style: theme.textTheme.bodySmall)),
                      const SizedBox(width: 12),
                      SizedBox(width: 120, child: Text('Credit', textAlign: TextAlign.right, style: theme.textTheme.bodySmall)),
                    ]),
                    const Divider(),
                    ...lines.map((l) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(children: [
                            Expanded(child: Text(l['account']!)),
                            SizedBox(
                                width: 120,
                                child: Text(l['debit']!.isEmpty ? '—' : l['debit']!, textAlign: TextAlign.right, style: TextStyle(color: AppTheme.success))),
                            const SizedBox(width: 12),
                            SizedBox(
                                width: 120,
                                child: Text(l['credit']!.isEmpty ? '—' : l['credit']!, textAlign: TextAlign.right, style: TextStyle(color: theme.colorScheme.error))),
                          ]),
                        )),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
