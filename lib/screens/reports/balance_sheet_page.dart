import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../starting/language/app_language.dart';

class BalanceSheetPage extends StatelessWidget {
  const BalanceSheetPage({super.key});

  static const String _asOnDate = '20/05/2026';

  static const List<_BalanceSheetGroup> _assets = [
    _BalanceSheetGroup(
      title: 'Bank Accounts',
      entries: [
        _BalanceSheetEntry(
          name: 'Faysal Bank',
          code: '13-0002',
          amount: 248800,
        ),
        _BalanceSheetEntry(
          name: 'Askari Bank',
          code: '13-0004',
          amount: 1042300,
        ),
        _BalanceSheetEntry(
          name: 'Mian Trust Bank',
          code: '13-0016',
          amount: 1757455,
        ),
      ],
    ),
    _BalanceSheetGroup(
      title: 'Cash',
      entries: [
        _BalanceSheetEntry(
          name: 'Cash in Hand',
          code: '13-0001',
          amount: 45200,
        ),
      ],
    ),
  ];

  static const List<_BalanceSheetGroup> _liabilities = [
    _BalanceSheetGroup(
      title: 'Capital',
      entries: [
        _BalanceSheetEntry(
          name: 'Mian Ehthesham Ahmad',
          code: '10-0003',
          amount: 5218150,
        ),
        _BalanceSheetEntry(
          name: 'Mian Abdul Majid',
          code: '10-0004',
          amount: 994280,
        ),
      ],
    ),
  ];

  static int get _totalAssets =>
      _assets.fold<int>(0, (sum, group) => sum + group.totalAmount);
  static int get _totalLiabilities =>
      _liabilities.fold<int>(0, (sum, group) => sum + group.totalAmount);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = appLanguageController.tr;
    final isBalanced = _totalAssets == _totalLiabilities;

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
              tr('Balance Sheet'),
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
              onPressed: () => _downloadBalanceSheet(context),
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
                      ? tr('Balance Sheet Balanced')
                      : tr('Balance Sheet Not Balanced'),
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
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
              itemCount: 4,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _SectionHeader(title: tr('Assets'));
                } else if (index == 1) {
                  return _SectionContent(groups: _assets, theme: theme);
                } else if (index == 2) {
                  return _SectionHeader(title: tr('Liabilities'));
                } else {
                  return _SectionContent(groups: _liabilities, theme: theme);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _SummaryCard(
                        label: tr('Total Assets'),
                        value: '₹${_formatIndian(_totalAssets)}',
                        valueColor: AppTheme.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SummaryCard(
                        label: tr('Total Liabilities'),
                        value: '₹${_formatIndian(_totalLiabilities)}',
                        valueColor: theme.colorScheme.error,
                      ),
                    ),
                  ],
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

  static void _downloadBalanceSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _DownloadBottomSheet(reportName: 'Balance Sheet'),
    );
  }
}

class _BalanceSheetGroup {
  const _BalanceSheetGroup({required this.title, required this.entries});

  final String title;
  final List<_BalanceSheetEntry> entries;

  int get totalAmount =>
      entries.fold<int>(0, (sum, entry) => sum + entry.amount);
}

class _BalanceSheetEntry {
  const _BalanceSheetEntry({
    required this.name,
    required this.code,
    required this.amount,
  });

  final String name;
  final String code;
  final int amount;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionContent extends StatelessWidget {
  const _SectionContent({required this.groups, required this.theme});

  final List<_BalanceSheetGroup> groups;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: groups
          .map((group) => _GroupCard(group: group, theme: theme))
          .toList(),
    );
  }
}

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group, required this.theme});

  final _BalanceSheetGroup group;
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
              amount: '₹${BalanceSheetPage._formatIndian(group.totalAmount)}',
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
              amount: '₹${BalanceSheetPage._formatIndian(group.totalAmount)}',
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

  final _BalanceSheetEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _TableRow(
      code: entry.code.isEmpty ? '—' : entry.code,
      name: entry.name,
      amount: entry.amount == 0
          ? '—'
          : '₹${BalanceSheetPage._formatIndian(entry.amount)}',
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

class _DownloadBottomSheet extends StatefulWidget {
  const _DownloadBottomSheet({required this.reportName});

  final String reportName;

  @override
  State<_DownloadBottomSheet> createState() => _DownloadBottomSheetState();
}

class _DownloadBottomSheetState extends State<_DownloadBottomSheet> {
  String _dateRange = 'all'; // all, today, last7, last30, custom
  String _format = 'pdf'; // pdf, csv
  bool _includeZeroBalances = true;
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final tr = appLanguageController.tr;
    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Download ${widget.reportName}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                tr('Date Range'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              ...[
                ('all', 'All Transactions'),
                ('today', 'Today'),
                ('last7', 'Last 7 Days'),
                ('last30', 'Last 30 Days'),
                ('custom', 'Custom Range'),
              ].map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _dateRange = option.$1),
                    child: Row(
                      children: [
                        Radio(
                          value: option.$1,
                          groupValue: _dateRange,
                          onChanged: (value) {
                            setState(() => _dateRange = value ?? 'all');
                          },
                        ),
                        Text(option.$2),
                      ],
                    ),
                  ),
                );
              }).toList(),
              if (_dateRange == 'custom') ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('From Date', style: theme.textTheme.bodySmall),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: _fromDate.toString().split(' ')[0],
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _fromDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() => _fromDate = date);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('To Date', style: theme.textTheme.bodySmall),
                          const SizedBox(height: 8),
                          TextFormField(
                            initialValue: _toDate.toString().split(' ')[0],
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              suffixIcon: const Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              final date = await showDatePicker(
                                context: context,
                                initialDate: _toDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (date != null) {
                                setState(() => _toDate = date);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 24),
              Text(
                tr('Download Format'),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _format = 'pdf'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _format == 'pdf'
                                ? theme.colorScheme.primary
                                : Colors.grey[300]!,
                            width: _format == 'pdf' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _format == 'pdf'
                              ? theme.colorScheme.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'PDF',
                            style: TextStyle(
                              color: _format == 'pdf'
                                  ? theme.colorScheme.primary
                                  : Colors.grey[600],
                              fontWeight: _format == 'pdf'
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _format = 'csv'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _format == 'csv'
                                ? theme.colorScheme.primary
                                : Colors.grey[300]!,
                            width: _format == 'csv' ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: _format == 'csv'
                              ? theme.colorScheme.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'CSV',
                            style: TextStyle(
                              color: _format == 'csv'
                                  ? theme.colorScheme.primary
                                  : Colors.grey[600],
                              fontWeight: _format == 'csv'
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: _includeZeroBalances,
                onChanged: (value) {
                  setState(() => _includeZeroBalances = value ?? true);
                },
                title: Text('Include Zero Balances'),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleDownload,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                  child: Text(
                    'Download ${_format.toUpperCase()}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleDownload() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Downloading ${widget.reportName} as ${_format.toUpperCase()}...',
        ),
      ),
    );
    Navigator.pop(context);
  }
}
