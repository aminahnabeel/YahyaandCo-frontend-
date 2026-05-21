import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../starting/language/app_language.dart';

class ProfitAndLossPage extends StatelessWidget {
  const ProfitAndLossPage({super.key});

  static const String _asOnDate = '20/05/2026';

  static const List<_ProfitAndLossGroup> _groups = [
    _ProfitAndLossGroup(
      title: 'Direct Income',
      entries: [
        _ProfitAndLossEntry(
          name: 'Flour Mill Commission',
          code: '07-0001',
          amount: 12220,
        ),
        _ProfitAndLossEntry(
          name: 'Sales Income',
          code: '08-0005',
          amount: 388000,
        ),
        _ProfitAndLossEntry(name: 'Brokerage', code: '08-0006', amount: 12100),
      ],
    ),
    _ProfitAndLossGroup(
      title: 'Company Expenses',
      entries: [
        _ProfitAndLossEntry(
          name: 'Taj Flour Mills',
          code: '09-0001',
          amount: 1136774,
        ),
        _ProfitAndLossEntry(
          name: 'United Flour Mills',
          code: '09-0003',
          amount: 682620,
        ),
        _ProfitAndLossEntry(
          name: 'Ameen Cotton Factory',
          code: '09-0006',
          amount: 149862,
        ),
        _ProfitAndLossEntry(
          name: 'AHMAB Cotton Factory',
          code: '09-0012',
          amount: 514200,
        ),
      ],
    ),
  ];

  static int get _totalIncome => _groups[0].totalAmount;
  static int get _totalExpenses => _groups[1].totalAmount;
  static int get _netProfit => _totalIncome - _totalExpenses;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = appLanguageController.tr;
    final isProfit = _netProfit >= 0;

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
              tr('Profit & Loss'),
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: isProfit ? const Color(0xFFE9F8EE) : const Color(0xFFFCE8E8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isProfit ? Icons.trending_up : Icons.trending_down,
                  size: 18,
                  color: isProfit ? AppTheme.success : theme.colorScheme.error,
                ),
                const SizedBox(width: 6),
                Text(
                  isProfit ? tr('Profit') : tr('Loss'),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isProfit
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
              name: tr('Description'),
              amount: tr('Amount'),
              textStyle: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              amountAlign: TextAlign.right,
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              itemCount: _groups.length + 1,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == _groups.length) {
                  return _NetProfitCard(
                    theme: theme,
                    income: _totalIncome,
                    expenses: _totalExpenses,
                    netProfit: _netProfit,
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
                    label: tr('Total Income'),
                    value: '₹${_formatIndian(_totalIncome)}',
                    valueColor: AppTheme.success,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SummaryCard(
                    label: tr('Total Expenses'),
                    value: '₹${_formatIndian(_totalExpenses)}',
                    valueColor: theme.colorScheme.error,
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
}

class _ProfitAndLossGroup {
  const _ProfitAndLossGroup({required this.title, required this.entries});

  final String title;
  final List<_ProfitAndLossEntry> entries;

  int get totalAmount =>
      entries.fold<int>(0, (sum, entry) => sum + entry.amount);
}

class _ProfitAndLossEntry {
  const _ProfitAndLossEntry({
    required this.name,
    required this.code,
    required this.amount,
  });

  final String name;
  final String code;
  final int amount;
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group, required this.theme});

  final _ProfitAndLossGroup group;
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
              amount: '₹${ProfitAndLossPage._formatIndian(group.totalAmount)}',
              textStyle: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              amountColor: AppTheme.success,
              amountAlign: TextAlign.right,
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
              amount: '₹${ProfitAndLossPage._formatIndian(group.totalAmount)}',
              textStyle: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              amountColor: AppTheme.success,
              amountAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountRow extends StatelessWidget {
  const _AccountRow({required this.entry});

  final _ProfitAndLossEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TableRow(
      code: entry.code.isEmpty ? '—' : entry.code,
      name: entry.name,
      amount: entry.amount == 0
          ? '—'
          : '₹${ProfitAndLossPage._formatIndian(entry.amount)}',
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
      ),
      amountColor: entry.amount == 0
          ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
          : AppTheme.success,
      amountAlign: TextAlign.right,
    );
  }
}

class _NetProfitCard extends StatelessWidget {
  const _NetProfitCard({
    required this.theme,
    required this.income,
    required this.expenses,
    required this.netProfit,
  });

  final ThemeData theme;
  final int income;
  final int expenses;
  final int netProfit;

  @override
  Widget build(BuildContext context) {
    final tr = appLanguageController.tr;
    final isProfit = netProfit >= 0;

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Column(
          children: [
            _TableRow(
              code: tr('Total Income'),
              name: '',
              amount: '₹${ProfitAndLossPage._formatIndian(income)}',
              textStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              amountColor: AppTheme.success,
              amountAlign: TextAlign.right,
            ),
            const Divider(height: 16),
            _TableRow(
              code: tr('Total Expenses'),
              name: '',
              amount: '₹${ProfitAndLossPage._formatIndian(expenses)}',
              textStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              amountColor: theme.colorScheme.error,
              amountAlign: TextAlign.right,
            ),
            const Divider(height: 16),
            _TableRow(
              code: isProfit ? 'Net Profit' : 'Net Loss',
              name: '',
              amount: '₹${ProfitAndLossPage._formatIndian(netProfit.abs())}',
              textStyle: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              amountColor: isProfit
                  ? AppTheme.success
                  : theme.colorScheme.error,
              amountAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({
    required this.code,
    required this.name,
    required this.amount,
    required this.textStyle,
    this.amountColor,
    this.amountAlign = TextAlign.left,
    this.amountGap = 20,
  });

  final String code;
  final String name;
  final String amount;
  final TextStyle? textStyle;
  final Color? amountColor;
  final TextAlign amountAlign;
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
          SizedBox(
            width: 60,
            child: Text(
              code,
              style: (textStyle ?? theme.textTheme.bodyMedium)?.copyWith(
                color: muted,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(name, style: textStyle ?? theme.textTheme.bodyMedium),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 110,
            child: Text(
              amount,
              style: (textStyle ?? theme.textTheme.bodyMedium)?.copyWith(
                color: amountColor,
              ),
              textAlign: amountAlign,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
              style: theme.textTheme.titleMedium?.copyWith(
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
