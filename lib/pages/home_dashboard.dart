import 'package:flutter/material.dart';
import '../theme.dart';
import 'add_transaction.dart';
import 'add_account.dart';
import 'reports_page.dart';
import 'ledger_accounts_page.dart';
import 'journal_entry.dart';

class HomeDashboard extends StatelessWidget {
  final String businessName;
  const HomeDashboard({super.key, required this.businessName});

  Widget _actionButton(BuildContext context, String label, IconData icon) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () async {
          if (label == 'Add Transaction') {
            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const AddTransactionPage()),
            );
            return;
          }

          if (label == 'Add Account') {
            await Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (_) => const AddAccountPage()));
            return;
          }
          if (label == 'Ledger' || label == 'Reports') {
            // support both labels while migrating to Ledger
            await Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (_) => const LedgerAccountsPage()));
            return;
          }
          if (label == 'Journal Entry') {
            await Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (_) => const JournalEntryPage()));
            return;
          }
        },
        icon: Icon(icon, size: 18, color: theme.colorScheme.primary),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          side: BorderSide(color: theme.colorScheme.outline, width: 1.2),
          foregroundColor: theme.colorScheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          textStyle: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _statCard(BuildContext c, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(c).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(c).textTheme.bodySmall),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(c).textTheme.titleMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    context,
                    'Total Balance',
                    '₹524,300',
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    context,
                    'Cash in Hand',
                    '₹45,200',
                    AppTheme.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _statCard(
                    context,
                    'Receivables',
                    '₹125,400',
                    AppTheme.warning,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    context,
                    'Payables',
                    '₹89,300',
                    Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _actionButton(context, 'Add Transaction', Icons.add),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    context,
                    'Add Account',
                    Icons.account_balance_wallet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _actionButton(
                    context,
                    'Journal Entry',
                    Icons.receipt_long,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(context, 'Ledger', Icons.account_balance_wallet),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Recent Transactions', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Office Rent'),
                    subtitle: const Text('Today'),
                    trailing: Text(
                      '-₹15,000',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Client Payment'),
                    subtitle: const Text('Today'),
                    trailing: Text(
                      '+₹42,500',
                      style: TextStyle(color: AppTheme.success),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Utilities'),
                    subtitle: const Text('Yesterday'),
                    trailing: Text(
                      '-₹3,200',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text('Sales Revenue'),
                    subtitle: const Text('Yesterday'),
                    trailing: Text(
                      '+₹28,900',
                      style: TextStyle(color: AppTheme.success),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
