import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../starting/language/app_language.dart';
import '../transactions/add_transaction.dart';
import '../accounts/add_account.dart';
import '../calculator/calculator_page.dart';
import '../ledger/ledger_accounts_page.dart';
import '../journal/journal_list_page.dart';

class HomeDashboard extends StatelessWidget {
  final String businessName;
  const HomeDashboard({super.key, required this.businessName});

  Widget _actionButton(
    BuildContext context,
    String action,
    String label,
    IconData icon,
  ) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 46,
      child: OutlinedButton.icon(
        onPressed: () async {
          if (action == 'add-transaction') {
            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const AddTransactionPage()),
            );
            return;
          }

          if (action == 'add-account') {
            await Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (_) => const AddAccountPage()));
            return;
          }
          if (action == 'ledger') {
            // support both labels while migrating to Ledger
            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const LedgerAccountsPage()),
            );
            return;
          }
          if (action == 'journal-entry') {
            await Navigator.of(
              context,
              rootNavigator: true,
            ).push(MaterialPageRoute(builder: (_) => const JournalListPage()));
            return;
          }

          if (action == 'calculator') {
            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (_) => const CalculatorPage()),
            );
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
    final strings = appLanguageController.strings;
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
                    strings.totalBalance,
                    '₹524,300',
                    theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    context,
                    strings.cashInHand,
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
                    strings.receivables,
                    '₹125,400',
                    AppTheme.warning,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _statCard(
                    context,
                    strings.payables,
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
                  child: _actionButton(
                    context,
                    'add-transaction',
                    strings.addTransaction,
                    Icons.add,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    context,
                    'add-account',
                    strings.addAccount,
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
                    'journal-entry',
                    strings.journalEntry,
                    Icons.receipt_long,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionButton(
                    context,
                    'ledger',
                    strings.ledger,
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
                    'calculator',
                    appLanguageController.tr('Calculator'),
                    Icons.calculate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(strings.recentTransactions, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(strings.officeRent),
                    subtitle: Text(strings.today),
                    trailing: Text(
                      '-₹15,000',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(strings.clientPayment),
                    subtitle: Text(strings.today),
                    trailing: Text(
                      '+₹42,500',
                      style: TextStyle(color: AppTheme.success),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(strings.utilities),
                    subtitle: Text(strings.yesterday),
                    trailing: Text(
                      '-₹3,200',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: Text(strings.salesRevenue),
                    subtitle: Text(strings.yesterday),
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
