import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../theme/theme.dart';
import '../../widgets/appbar.dart';

class JournalDetailsPage extends StatelessWidget {
  const JournalDetailsPage({super.key, required this.entry});

  final Map<String, dynamic> entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;

    final lines = [
      {
        'account': 'Bank Account',
        'debit': entry['voucher'] == 'JV-1' ? '50,000' : '',
        'credit': '',
      },
      {
        'account': 'Sales Revenue',
        'debit': '',
        'credit': entry['voucher'] == 'JV-1' ? '50,000' : '',
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: '${strings.journalVoucherLabel} ${entry['voucher']}',
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
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry['voucher']?.toString() ?? 'N/A',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _detailRow(
                        label: strings.journalDateLabel,
                        value: entry['date']?.toString() ?? appLanguageController.tr('N/A'),
                        theme: theme,
                      ),
                      const SizedBox(height: 8),
                      _detailRow(
                        label: strings.journalDescriptionLabel,
                        value: entry['desc']?.toString() ?? appLanguageController.tr('N/A'),
                        theme: theme,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                strings.journalEntriesLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              strings.journalAccountLabel,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              strings.journalDebitLabel,
                              textAlign: TextAlign.right,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              strings.journalCreditLabel,
                              textAlign: TextAlign.right,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      ...lines.map((line) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(line['account'] ?? ''),
                              ),
                              Expanded(
                                child: Text(
                                  (line['debit'] ?? '').isEmpty
                                      ? '-'
                                      : line['debit']!,
                                  textAlign: TextAlign.right,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  (line['credit'] ?? '').isEmpty
                                      ? '-'
                                      : line['credit']!,
                                  textAlign: TextAlign.right,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.error,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow({
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
