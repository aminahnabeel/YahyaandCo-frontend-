import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';

class JournalEntryPage extends StatefulWidget {
  const JournalEntryPage({super.key});

  @override
  State<JournalEntryPage> createState() => _JournalEntryPageState();
}

class _JournalEntryLine {
  _JournalEntryLine({String? account, String? debit, String? credit})
    : accountController = TextEditingController(text: account ?? ''),
      debitController = TextEditingController(text: debit ?? ''),
      creditController = TextEditingController(text: credit ?? '');

  final TextEditingController accountController;
  final TextEditingController debitController;
  final TextEditingController creditController;

  void dispose() {
    accountController.dispose();
    debitController.dispose();
    creditController.dispose();
  }
}

class _JournalEntryPageState extends State<JournalEntryPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _voucherNumberController = TextEditingController(
    text: 'JV/2024-05/001',
  );

  DateTime _selectedDate = DateTime.now();
  String _voucherType = 'Journal Voucher';
  String? _validationError;

  final List<_JournalEntryLine> _lines = [
    _JournalEntryLine(account: 'Bank Account', debit: '50000', credit: ''),
    _JournalEntryLine(account: 'Sales Revenue', debit: '', credit: '50000'),
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _voucherNumberController.dispose();
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  void _addLine() {
    setState(() {
      _lines.add(_JournalEntryLine());
      _validationError = null;
    });
  }

  void _removeLine(int index) {
    if (_lines.length <= 1) return;
    setState(() {
      _lines[index].dispose();
      _lines.removeAt(index);
      _validationError = null;
    });
  }

  bool _validateDebitCredit() {
    double totalDebit = 0;
    double totalCredit = 0;

    for (final line in _lines) {
      final debit =
          double.tryParse(line.debitController.text.replaceAll(',', '').trim()) ??
          0;
      final credit =
          double.tryParse(
            line.creditController.text.replaceAll(',', '').trim(),
          ) ??
          0;
      totalDebit += debit;
      totalCredit += credit;
    }

    return (totalDebit - totalCredit).abs() <= 0.01;
  }

  void _save() {
    final strings = appLanguageController.strings;
    if (!_validateDebitCredit()) {
      setState(() {
        _validationError = strings.debitCreditMismatchError;
      });
      return;
    }

    Navigator.of(context).pop({
      'voucherType': _voucherType,
      'date': _selectedDate,
      'description': _descriptionController.text.trim(),
      'voucherNumber': _voucherNumberController.text.trim(),
      'lines':
          _lines
              .map(
                (line) => {
                  'account': line.accountController.text.trim(),
                  'debit': line.debitController.text.trim(),
                  'credit': line.creditController.text.trim(),
                },
              )
              .toList(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;

    return Scaffold(
      appBar: CustomAppBar(
        title: strings.journalEntryPageTitle,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        strings.voucherTypeLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(
                                () => _voucherType = 'Journal Voucher',
                              ),
                              child: Text(appLanguageController.tr('Journal Voucher')),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => setState(
                                () => _voucherType = 'Cash Payment',
                              ),
                              child: Text(appLanguageController.tr('Cash Payment')),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.voucherNumberLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _voucherNumberController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.journalDateLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) {
                            setState(() => _selectedDate = picked);
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                        label: Text(
                          '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.journalDescriptionLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: appLanguageController.tr('Enter description'),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        strings.journalEntriesLabel,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_validationError != null)
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _validationError!,
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ),
                      ..._lines.asMap().entries.map((entry) {
                        final index = entry.key;
                        final line = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextField(
                                  controller: line.accountController,
                                  decoration: InputDecoration(
                                    labelText: strings.journalAccountLabel,
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: line.debitController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    labelText: strings.journalDebitLabel,
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: TextField(
                                  controller: line.creditController,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.right,
                                  decoration: InputDecoration(
                                    labelText: strings.journalCreditLabel,
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                onPressed: _lines.length > 1
                                    ? () => _removeLine(index)
                                    : null,
                                icon: const Icon(Icons.delete_outline),
                                tooltip: strings.removeLineButton,
                              ),
                            ],
                          ),
                        );
                      }),
                      OutlinedButton.icon(
                        onPressed: _addLine,
                        icon: const Icon(Icons.add),
                        label: Text(strings.addLineButton),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RoundedPrimaryButton(
                label: strings.saveEntryButton,
                onPressed: _save,
                fullWidth: true,
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(strings.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
