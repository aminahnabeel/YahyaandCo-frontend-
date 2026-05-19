import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final trialRows = [
      {'account': 'Bank Account', 'debit': '₹245,300', 'credit': ''},
      {'account': 'Cash', 'debit': '₹45,200', 'credit': ''},
      {'account': 'Sales', 'debit': '', 'credit': '₹71,400'},
      {'account': 'Expenses', 'debit': '₹18,200', 'credit': ''},
    ];

    // compute totals (simple parsing removing non-digits)
    int parseAmount(String s) {
      if (s.isEmpty) return 0;
      final cleaned = s.replaceAll(RegExp(r'[^0-9]'), '');
      return int.tryParse(cleaned) ?? 0;
    }

    final totalDebit = trialRows.fold<int>(
      0,
      (sum, r) => sum + parseAmount(r['debit']!),
    );
    final totalCredit = trialRows.fold<int>(
      0,
      (sum, r) => sum + parseAmount(r['credit']!),
    );

    final ledger = [
      {
        'label': 'Opening Balance',
        'amount': '₹100,000',
        'color': Theme.of(context).colorScheme.onSurface,
      },
      {
        'label': 'Total Credits',
        'amount': '₹71,400',
        'color': Theme.of(context).colorScheme.primary,
      },
      {
        'label': 'Total Debits',
        'amount': '₹18,200',
        'color': Theme.of(context).colorScheme.error,
      },
      {
        'label': 'Closing Balance',
        'amount': '₹153,200',
        'color': Theme.of(context).colorScheme.primary,
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Trial Balance',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(1.3),
                        2: FlexColumnWidth(1.3),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Account',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Debit',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Credit',
                                textAlign: TextAlign.right,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        ...trialRows.map(
                          (r) => TableRow(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(
                                    context,
                                  ).dividerColor.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  r['account']!,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  r['debit']!.isEmpty ? '—' : r['debit']!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: r['debit']!.isEmpty
                                        ? Theme.of(context).disabledColor
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Text(
                                  r['credit']!.isEmpty ? '—' : r['credit']!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: r['credit']!.isEmpty
                                        ? Theme.of(context).disabledColor
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TableRow(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                'Total',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                '₹${totalDebit.toString()}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                '₹${totalCredit.toString()}',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ledger Summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...ledger.map(
                      (row) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                row['label'] as String,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                row['amount'] as String,
                                style: TextStyle(
                                  color: (row['color'] as Color),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 18, thickness: 1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
