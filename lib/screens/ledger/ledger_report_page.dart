import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../widgets/appbar.dart';
import '../../theme/theme.dart';

class LedgerReportPage extends StatelessWidget {
  const LedgerReportPage({
    super.key,
    required this.accountName,
    required this.accountCode,
  });

  final String accountName;
  final String accountCode;

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;
    final rows = [
      {
        'date': '2024-05-01',
        'voucher': 'JV-1',
        'debit': '50,000',
        'credit': '',
        'balance': '50,000',
      },
      {
        'date': '2024-05-03',
        'voucher': 'JV-2',
        'debit': '',
        'credit': '10,000',
        'balance': '40,000',
      },
      {
        'date': '2024-05-10',
        'voucher': 'CP-1',
        'debit': '20,000',
        'credit': '',
        'balance': '60,000',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: '${strings.ledger} - $accountName',
        onBackPressed: () => Navigator.of(context).pop(),
        showTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accountName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        accountCode,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  strings.dateLabel,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  strings.journalVoucherLabel,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  strings.debitLabel,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  strings.creditLabel,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  appLanguageController.tr('Balance'),
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: ListView.separated(
                            itemCount: rows.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (ctx, i) {
                              final r = rows[i];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex: 2, child: Text(r['date']!)),
                                    Expanded(
                                      flex: 3,
                                      child: Text(r['voucher']!),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r['debit']!.isEmpty ? '—' : r['debit']!,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: AppTheme.success,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r['credit']!.isEmpty
                                            ? '—'
                                            : r['credit']!,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        r['balance']!,
                                        textAlign: TextAlign.right,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
