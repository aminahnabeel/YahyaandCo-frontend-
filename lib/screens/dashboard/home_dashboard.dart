import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../starting/language/app_language.dart';
import '../transactions/add_transaction.dart';
import '../accounts/add_account.dart';
import '../calculator/calculator_page.dart';
import '../ledger/ledger_accounts_page.dart';
import '../journal/journal_list_page.dart';
import '../../state/business_workspace_controller.dart';

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
    final strings = appLanguageController.strings;
    return ValueListenableBuilder<BusinessWorkspaceState>(
      valueListenable: businessWorkspaceController,
      builder: (context, state, _) {
        final theme = Theme.of(context);
        final business = state.selectedBusiness;
        return SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: SingleChildScrollView(
              key: ValueKey(business.id),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [
                          business.accentColor.withValues(alpha: 0.16),
                          theme.colorScheme.surface,
                        ],
                      ),
                      border: Border.all(
                        color: business.accentColor.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          business.name,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          business.type,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          context,
                          strings.totalBalance,
                          business.metrics.totalBalance,
                          theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _statCard(
                          context,
                          strings.cashInHand,
                          business.metrics.cashInHand,
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
                          business.metrics.receivables,
                          AppTheme.warning,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _statCard(
                          context,
                          strings.payables,
                          business.metrics.payables,
                          theme.colorScheme.error,
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
                  Text(
                    strings.recentTransactions,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Card(
                    child: Column(
                      children: [
                        for (var index = 0;
                            index < business.recentTransactions.length;
                            index++)
                          Column(
                            children: [
                              ListTile(
                                title: Text(business.recentTransactions[index].title),
                                subtitle: Text(
                                  index.isEven ? strings.today : strings.yesterday,
                                ),
                                trailing: Text(
                                  business.recentTransactions[index].amountLabel,
                                  style: TextStyle(
                                    color: business.recentTransactions[index].isDebit
                                        ? theme.colorScheme.error
                                        : AppTheme.success,
                                  ),
                                ),
                              ),
                              if (index != business.recentTransactions.length - 1)
                                const Divider(height: 1),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
