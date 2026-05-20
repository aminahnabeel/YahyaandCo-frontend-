import 'package:flutter/material.dart';
import '../ledger/ledger_accounts_page.dart';
import 'trial_balance_page.dart';
import 'cash_book_page.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {
        'title': 'Ledger',
        'description': 'View account-wise transactions and running balance',
        'icon': Icons.book,
        'iconColor': Colors.deepOrange,
        'page': const LedgerAccountsPage(),
      },
      {
        'title': 'Trial Balance',
        'description': 'Summary of all account debit and credit balances',
        'icon': Icons.balance,
        'iconColor': Colors.orange,
        'page': const TrialBalancePage(),
      },
      {
        'title': 'Cash Book',
        'description':
            'Track all cash inflows and outflows with running balance',
        'icon': Icons.monetization_on,
        'iconColor': Colors.amber,
        'page': const CashBookPage(),
      },
    ];

    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: reports.length,
        itemBuilder: (context, index) {
          final report = reports[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: report['page'] != null
                  ? () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (_) => report['page'] as Widget,
                        ),
                      );
                    }
                  : null,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Colored Icon
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (report['iconColor'] as Color).withValues(
                            alpha: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          report['icon'] as IconData,
                          color: report['iconColor'] as Color,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report['title'] as String,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              report['description'] as String,
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
