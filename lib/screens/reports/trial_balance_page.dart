import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../starting/language/app_language.dart';

class TrialBalancePage extends StatelessWidget {
  const TrialBalancePage({super.key});

  static const String _asOnDate = '20/05/2026';

  static const List<_TrialBalanceGroup> _groups = [
    _TrialBalanceGroup(
      title: 'Bank Account',
      entries: [
        _TrialBalanceEntry(
          name: 'Faysal Bank',
          code: '13-0002',
          debit: 0,
          credit: 248800,
        ),
        _TrialBalanceEntry(
          name: 'Askari Bank',
          code: '13-0004',
          debit: 0,
          credit: 1042300,
        ),
        _TrialBalanceEntry(
          name: 'Mian Trust Bank',
          code: '13-0016',
          debit: 0,
          credit: 1757455,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Capital',
      entries: [
        _TrialBalanceEntry(
          name: 'Mian Ehthesham Ahmad',
          code: '10-0003',
          debit: 0,
          credit: 5218150,
        ),
        _TrialBalanceEntry(
          name: 'Mian Abdul Majid',
          code: '10-0004',
          debit: 0,
          credit: 994280,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Employee Account',
      entries: [
        _TrialBalanceEntry(
          name: 'Muhammad Asif Khana Abbasi',
          code: '11-0001',
          debit: 0,
          credit: 543830,
        ),
        _TrialBalanceEntry(
          name: 'Abdul Kareem Shah',
          code: '11-0002',
          debit: 0,
          credit: 543830,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Owner Drawing',
      entries: [
        _TrialBalanceEntry(
          name: 'Mian Gul Tahir',
          code: '12-0003',
          debit: 0,
          credit: 38330,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Direct Income',
      entries: [
        _TrialBalanceEntry(
          name: 'Flour Mill Commission',
          code: '07-0001',
          debit: 12220,
          credit: 0,
        ),
        _TrialBalanceEntry(
          name: 'Sales Income',
          code: '08-0005',
          debit: 0,
          credit: 388000,
        ),
        _TrialBalanceEntry(
          name: 'Brokerage',
          code: '08-0006',
          debit: 0,
          credit: 12100,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Company Expenses',
      entries: [
        _TrialBalanceEntry(
          name: 'Taj Flour Mills',
          code: '09-0001',
          debit: 1136774,
          credit: 0,
        ),
        _TrialBalanceEntry(
          name: 'United Flour Mills',
          code: '09-0003',
          debit: 682620,
          credit: 0,
        ),
        _TrialBalanceEntry(
          name: 'Ameen Cotton Factory',
          code: '09-0006',
          debit: 149862,
          credit: 0,
        ),
        _TrialBalanceEntry(
          name: 'AHMAB Cotton Factory',
          code: '09-0012',
          debit: 514200,
          credit: 0,
        ),
      ],
    ),
    _TrialBalanceGroup(
      title: 'Cash Account',
      entries: [
        _TrialBalanceEntry(
          name: 'Cash in Hand',
          code: '13-0001',
          debit: 45200,
          credit: 0,
        ),
      ],
    ),
  ];

  static int get _totalDebit =>
      _groups.fold<int>(0, (sum, group) => sum + group.totalDebit);
  static int get _totalCredit =>
      _groups.fold<int>(0, (sum, group) => sum + group.totalCredit);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;
    final tr = appLanguageController.tr;
    final isBalanced = _totalDebit == _totalCredit;

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
              strings.trialBalanceTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              '${tr('As on')} $_asOnDate',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton.icon(
              onPressed: () => _downloadTrialBalance(context),
              icon: const Icon(Icons.download, size: 18),
              label: Text(tr('Download')),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: isBalanced
                ? const Color(0xFFE9F8EE)
                : const Color(0xFFFCE8E8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isBalanced ? Icons.check_circle : Icons.close,
                  size: 18,
                  color: isBalanced
                      ? AppTheme.success
                      : theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  isBalanced
                      ? tr('Trial Balance Balanced')
                      : tr('Trial Balance Not Balanced'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isBalanced
                        ? AppTheme.success
                        : theme.colorScheme.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: theme.colorScheme.primary,
            child: _TableRow(
              code: tr('Code'),
              name: strings.journalAccountLabel,
              debit: strings.debitLabel,
              credit: strings.creditLabel,
              textStyle: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              debitAlign: TextAlign.right,
              creditAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              itemCount: _groups.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == _groups.length) {
                  return _GrandTotalCard(
                    theme: theme,
                    debit: _totalDebit,
                    credit: _totalCredit,
                  );
                }

                final group = _groups[index];
                return _GroupCard(group: group, theme: theme);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: tr('Total Debit'),
                    value: '₹${_formatIndian(_totalDebit)}',
                    valueColor: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    label: tr('Total Credit'),
                    value: '₹${_formatIndian(_totalCredit)}',
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

  static String _formatIndian(int value) {
    final digits = value.abs().toString();
    if (digits.length <= 3) {
      return value.toString();
    }

    final lastThree = digits.substring(digits.length - 3);
    String remaining = digits.substring(0, digits.length - 3);
    final parts = <String>[];

    while (remaining.length > 2) {
      parts.insert(0, remaining.substring(remaining.length - 2));
      remaining = remaining.substring(0, remaining.length - 2);
    }

    if (remaining.isNotEmpty) {
      parts.insert(0, remaining);
    }

    final formatted = '${parts.join(',')},$lastThree';
    return value < 0 ? '-$formatted' : formatted;
  }

  static void _downloadTrialBalance(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Downloading Trial Balance...')),
    );
  }
}

class _TrialBalanceGroup {
  const _TrialBalanceGroup({required this.title, required this.entries});

  final String title;
  final List<_TrialBalanceEntry> entries;

  int get totalDebit => entries.fold<int>(0, (sum, entry) => sum + entry.debit);
  int get totalCredit =>
      entries.fold<int>(0, (sum, entry) => sum + entry.credit);
}

class _TrialBalanceEntry {
  const _TrialBalanceEntry({
    required this.name,
    required this.code,
    required this.debit,
    required this.credit,
  });

  final String name;
  final String code;
  final int debit;
  final int credit;
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group, required this.theme});

  final _TrialBalanceGroup group;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.8,
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            child: _TableRow(
              code: group.title,
              name: '',
              debit: '₹${TrialBalancePage._formatIndian(group.totalDebit)}',
              credit: '₹${TrialBalancePage._formatIndian(group.totalCredit)}',
              textStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              debitColor: theme.colorScheme.error,
              creditColor: AppTheme.success,
              debitAlign: TextAlign.right,
              creditAlign: TextAlign.right,
            ),
          ),
          const Divider(height: 1),
          ...group.entries.asMap().entries.expand((entry) {
            final item = entry.value;
            return [_AccountRow(entry: item), const Divider(height: 1)];
          }).toList()..removeLast(),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: _TableRow(
              code: 'Group Total',
              name: '',
              debit: '₹${TrialBalancePage._formatIndian(group.totalDebit)}',
              credit: '₹${TrialBalancePage._formatIndian(group.totalCredit)}',
              textStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              debitColor: theme.colorScheme.error,
              creditColor: AppTheme.success,
              debitAlign: TextAlign.right,
              creditAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.entry});

  final _TrialBalanceEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TableRow(
      code: entry.code.isEmpty ? '—' : entry.code,
      name: entry.name,
      debit: entry.debit == 0
          ? '—'
          : '₹${TrialBalancePage._formatIndian(entry.debit)}',
      credit: entry.credit == 0
          ? '—'
          : '₹${TrialBalancePage._formatIndian(entry.credit)}',
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      debitColor: entry.debit == 0
          ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
          : theme.colorScheme.error,
      creditColor: entry.credit == 0
          ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
          : AppTheme.success,
      debitAlign: TextAlign.right,
      creditAlign: TextAlign.right,
    );
  }
}

class _GrandTotalCard extends StatelessWidget {
  const _GrandTotalCard({
    required this.theme,
    required this.debit,
    required this.credit,
  });

  final ThemeData theme;
  final int debit;
  final int credit;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: _TableRow(
          code: 'Grand Total',
          name: '',
          debit: '₹${TrialBalancePage._formatIndian(debit)}',
          credit: '₹${TrialBalancePage._formatIndian(credit)}',
          textStyle: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          debitColor: theme.colorScheme.error,
          creditColor: AppTheme.success,
          debitAlign: TextAlign.right,
          creditAlign: TextAlign.right,
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.code,
    required this.name,
    required this.debit,
    required this.credit,
    required this.textStyle,
    this.debitColor,
    this.creditColor,
    this.debitAlign = TextAlign.left,
    this.creditAlign = TextAlign.left,
    this.amountGap = 20,
  });

  final String code;
  final String name;
  final String debit;
  final String credit;
  final TextStyle? textStyle;
  final Color? debitColor;
  final Color? creditColor;
  final TextAlign debitAlign;
  final TextAlign creditAlign;
  final double amountGap;

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
            flex: 2,
            child: Text(
              code,
              style: textStyle?.copyWith(
                color: code == '—' || code.isEmpty
                    ? muted
                    : textStyle?.color ?? theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 5, child: Text(name, style: textStyle)),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              debit,
              textAlign: debitAlign,
              style: textStyle?.copyWith(
                color: debit == '—'
                    ? muted
                    : debitColor ??
                          textStyle?.color ??
                          theme.colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(width: amountGap),
          Expanded(
            flex: 2,
            child: Text(
              credit,
              textAlign: creditAlign,
              style: textStyle?.copyWith(
                color: credit == '—'
                    ? muted
                    : creditColor ??
                          textStyle?.color ??
                          theme.colorScheme.onSurface,
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
