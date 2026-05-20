import 'package:flutter/material.dart';

import '../../theme/theme.dart';

class TrialBalancePage extends StatelessWidget {
  const TrialBalancePage({super.key});

  static const String _asOnDate = '20/05/2026';

  static final List<Map<String, String>> _accounts = [
    {
      'name': 'Bank of India - Current',
      'code': 'BI-001',
      'debit': '',
      'credit': '1,45,000',
    },
    {
      'name': 'HDFC Bank',
      'code': 'HB-001',
      'debit': '',
      'credit': '89,500',
    },
    {
      'name': 'Cash in Hand',
      'code': '',
      'debit': '45,200',
      'credit': '',
    },
    {
      'name': 'ICICI Bank',
      'code': 'ICICI-23',
      'debit': '1,24,500',
      'credit': '',
    },
    {
      'name': 'Sales Revenue',
      'code': 'REV-01',
      'debit': '',
      'credit': '3,25,400',
    },
    {
      'name': 'Purchase Expense',
      'code': 'EXP-01',
      'debit': '2,34,800',
      'credit': '',
    },
    {
      'name': 'Capital Account',
      'code': '',
      'debit': '',
      'credit': '5,00,000',
    },
  ];

  static const String _totalDebit = '10,84,000';
  static const String _totalCredit = '9,64,900';
  static const String _totalDebitShort = '10.84L';
  static const String _totalCreditShort = '9.65L';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 72,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trial Balance',
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              'As on $_asOnDate',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: const Color(0xFFFCE8E8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.close,
                  size: 18,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  'Trial Balance Not Balanced',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: primary,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Account',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Debit',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Credit',
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _accounts.length + 1,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: theme.dividerColor),
              itemBuilder: (context, index) {
                if (index == _accounts.length) {
                  return _TotalRow(theme: theme);
                }
                final row = _accounts[index];
                return _AccountRow(
                  name: row['name']!,
                  code: row['code']!,
                  debit: row['debit']!,
                  credit: row['credit']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: 'Total Debit',
                    value: '₹$_totalDebitShort',
                    valueColor: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    label: 'Total Credit',
                    value: '₹$_totalCreditShort',
                    valueColor: AppTheme.success,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({
    required this.name,
    required this.code,
    required this.debit,
    required this.credit,
  });

  final String name;
  final String code;
  final String debit;
  final String credit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurface.withValues(alpha: 0.45);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (code.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(code, style: theme.textTheme.bodySmall?.copyWith(color: muted)),
                ],
              ],
            ),
          ),
          Expanded(
            child: Text(
              debit.isEmpty ? '—' : '₹$debit',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: debit.isEmpty ? muted : theme.colorScheme.error,
                fontWeight: debit.isEmpty ? FontWeight.normal : FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              credit.isEmpty ? '—' : '₹$credit',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: credit.isEmpty ? muted : AppTheme.success,
                fontWeight: credit.isEmpty ? FontWeight.normal : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Total',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '₹${TrialBalancePage._totalDebit}',
              textAlign: TextAlign.right,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '₹${TrialBalancePage._totalCredit}',
              textAlign: TextAlign.right,
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.success,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  final String label;
  final String value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
