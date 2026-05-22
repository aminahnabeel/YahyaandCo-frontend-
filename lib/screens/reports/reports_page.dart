import 'package:flutter/material.dart';
import '../ledger/ledger_accounts_page.dart';
import 'trial_balance_page.dart';
import 'cash_book_page.dart';
import 'profit_and_loss_page.dart';
import 'balance_sheet_page.dart';
import '../../state/business_workspace_controller.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BusinessWorkspaceState>(
      valueListenable: businessWorkspaceController,
      builder: (context, state, _) {
        final business = state.selectedBusiness;
        final reports = business.reports;

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      business.accentColor.withValues(alpha: 0.14),
                      Theme.of(context).colorScheme.surface,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Report snapshots update instantly when the business changes.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.72),
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ...reports.map(
                (report) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: GestureDetector(
                    onTap: () {
                      final page = _reportPageForTitle(report.title);
                      if (page != null) {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (_) => page),
                        );
                      }
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: report.iconColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                report.icon,
                                color: report.iconColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          report.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        report.value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              color: report.iconColor,
                                            ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    report.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget? _reportPageForTitle(String title) {
    switch (title) {
      case 'Ledger':
        return const LedgerAccountsPage();
      case 'Trial Balance':
        return const TrialBalancePage();
      case 'Cash Book':
        return const CashBookPage();
      case 'Profit & Loss':
        return const ProfitAndLossPage();
      case 'Balance Sheet':
        return const BalanceSheetPage();
      default:
        return null;
    }
  }
}
