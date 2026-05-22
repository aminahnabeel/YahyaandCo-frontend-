import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../theme/theme.dart';

class CashBookPage extends StatelessWidget {
  const CashBookPage({super.key});

  static const String _accountSubtitle = 'Cash in Hand Account';
  static const String _totalInflowShort = '125.5K';
  static const String _totalOutflowShort = '53.5K';
  static const String _closingBalanceShort = '72.0K';
  static const String _totalInflow = '1,25,500';
  static const String _totalOutflow = '53,500';
  static const String _closingBalance = '72,000';

  static final List<Map<String, String>> _transactions = [
    {
      'date': '01/05/2024',
      'description': 'Opening Balance',
      'inflow': '',
      'outflow': '',
      'balance': '45,000',
    },
    {
      'date': '03/05/2024',
      'description': 'Office Rent Payment',
      'inflow': '',
      'outflow': '8,000',
      'balance': '37,000',
    },
    {
      'date': '05/05/2024',
      'description': 'Client Payment - ABC Ltd',
      'inflow': '42,500',
      'outflow': '',
      'balance': '79,500',
    },
    {
      'date': '10/05/2024',
      'description': 'Petty Cash Purchase',
      'inflow': '',
      'outflow': '2,200',
      'balance': '77,300',
    },
    {
      'date': '15/05/2024',
      'description': 'Sales Collection',
      'inflow': '38,000',
      'outflow': '',
      'balance': '1,15,300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final tr = appLanguageController.tr;

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
              tr('Cash Book'),
              style: theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            Text(
              _accountSubtitle,
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
              onPressed: () => _downloadCashBook(context),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: _SummaryCard(
                    label: tr('Total Inflow'),
                    value: '₹$_totalInflowShort',
                    valueColor: AppTheme.success,
                    filled: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    label: tr('Total Outflow'),
                    value: '₹$_totalOutflowShort',
                    valueColor: theme.colorScheme.error,
                    filled: false,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryCard(
                    label: tr('Closing Balance'),
                    value: '₹$_closingBalanceShort',
                    valueColor: Colors.white,
                    filled: true,
                    backgroundColor: primary,
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
                SizedBox(
                  width: 72,
                  child: Text(
                    tr('Date'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    tr('Description'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 56,
                  child: Text(
                    tr('Inflow'),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 56,
                  child: Text(
                    tr('Outflow'),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 64,
                  child: Text(
                    tr('Balance'),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: _transactions.length + 1,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: theme.dividerColor),
              itemBuilder: (context, index) {
                if (index == _transactions.length) {
                  return _TotalRow(theme: theme, primary: primary);
                }
                final row = _transactions[index];
                return _TransactionRow(
                  date: row['date']!,
                  description: row['description']!,
                  inflow: row['inflow']!,
                  outflow: row['outflow']!,
                  balance: row['balance']!,
                  balanceColor: primary,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static void _downloadCashBook(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _DownloadBottomSheet(reportName: 'Cash Book'),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.filled,
    this.backgroundColor,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool filled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColor = filled
        ? Colors.white.withValues(alpha: 0.9)
        : theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: filled ? backgroundColor : theme.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: filled ? null : Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: labelColor,
              fontSize: 11,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              color: valueColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    required this.date,
    required this.description,
    required this.inflow,
    required this.outflow,
    required this.balance,
    required this.balanceColor,
  });

  final String date;
  final String description;
  final String inflow;
  final String outflow;
  final String balance;
  final Color balanceColor;

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
            width: 72,
            child: Text(
              date,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              inflow.isEmpty ? '—' : '₹$inflow',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall?.copyWith(
                color: inflow.isEmpty ? muted : AppTheme.success,
                fontWeight: inflow.isEmpty
                    ? FontWeight.normal
                    : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 56,
            child: Text(
              outflow.isEmpty ? '—' : '₹$outflow',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall?.copyWith(
                color: outflow.isEmpty ? muted : theme.colorScheme.error,
                fontWeight: outflow.isEmpty
                    ? FontWeight.normal
                    : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 64,
            child: Text(
              '₹$balance',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodySmall?.copyWith(
                color: balanceColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({required this.theme, required this.primary});

  final ThemeData theme;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        children: [
          const SizedBox(width: 72),
          Expanded(
            flex: 2,
            child: Text(
              'Total',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 56,
            child: Text(
              '₹${CashBookPage._totalInflow}',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.success,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 56,
            child: Text(
              '₹${CashBookPage._totalOutflow}',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 4),
          SizedBox(
            width: 64,
            child: Text(
              '₹${CashBookPage._closingBalance}',
              textAlign: TextAlign.right,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: primary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
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
