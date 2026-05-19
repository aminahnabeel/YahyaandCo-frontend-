import 'package:flutter/material.dart';

import '../widgets/appbar.dart';
import '../widgets/button.dart';
import '../theme.dart';

class JournalEntryPage extends StatefulWidget {
  const JournalEntryPage({super.key});

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  String _voucherType = 'Journal Voucher';

  final List<Map<String, String>> _lines = [
    {'account': 'Bank Account', 'debit': '50,000', 'credit': ''},
    {'account': 'Sales Revenue', 'debit': '', 'credit': '50,000'},
  ];

  void _addLine() {
    setState(() => _lines.add({'account': '', 'debit': '', 'credit': ''}));
  }

  void _save() {
    Navigator.of(context).pop({'voucherType': _voucherType, 'lines': _lines});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Journal Entry',
        onBackPressed: () => Navigator.of(context).pop(),
        showTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Voucher Type',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(() => _voucherType = 'Journal Voucher'),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: _voucherType == 'Journal Voucher'
                                    ? theme.colorScheme.primary.withOpacity(0.08)
                                    : null,
                                side: BorderSide(color: theme.colorScheme.outline),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text(
                                'Journal Voucher',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(() => _voucherType = 'Contra Voucher'),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: _voucherType == 'Contra Voucher'
                                    ? theme.colorScheme.primary.withOpacity(0.08)
                                    : null,
                                side: BorderSide(color: theme.colorScheme.outline),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: Text(
                                'Contra Voucher',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: _voucherType == 'Contra Voucher' ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Voucher Number',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(text: 'JV/2024-05/001'),
                        readOnly: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        'Journal Entries',
                        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: theme.cardColor),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(child: Text('Account', style: theme.textTheme.bodySmall)),
                                  SizedBox(width: 120, child: Text('Debit', style: theme.textTheme.bodySmall, textAlign: TextAlign.right)),
                                  SizedBox(width: 120, child: Text('Credit', style: theme.textTheme.bodySmall, textAlign: TextAlign.right)),
                                ],
                              ),
                            ),
                            const Divider(height: 1),
                            ..._lines.map((l) {
                              return ListTile(
                                dense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                title: Text(l['account'] ?? ''),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(width: 100, child: Text(l['debit'] ?? '', textAlign: TextAlign.right, style: TextStyle(color: AppTheme.success))),
                                    const SizedBox(width: 12),
                                    SizedBox(width: 100, child: Text(l['credit'] ?? '', textAlign: TextAlign.right, style: TextStyle(color: theme.colorScheme.error))),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              RoundedPrimaryButton(label: 'Save Entry', onPressed: _save, fullWidth: true),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    foregroundColor: theme.colorScheme.onSurface,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
