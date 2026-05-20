import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../widgets/appbar.dart';
import '../../widgets/button.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({super.key});

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  String _currency = 'INR (₹)';
  String _accountType = 'Bank';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _openingBalanceController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _openingBalanceController.text = '0.00';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _openingBalanceController.dispose();
    super.dispose();
  }

  void _save() {
    final data = {
      'currency': _currency,
      'accountType': _accountType,
      'name': _nameController.text,
      'openingBalance': _openingBalanceController.text,
    };
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;
    final currencies = ['INR (₹)', 'USD ()', 'EUR (€)', 'GBP (£)'];
    final accountTypes = [
      'Bank',
      'Cash',
      'Receivable (Customer)',
      'Payable (Supplier)',
      'Credit Card',
      'Loan',
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: strings.addAccountTitle,
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        strings.accountNameLabel,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: strings.accountNameHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        strings.accountTypeLabel,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _accountType,
                        items: accountTypes
                            .map(
                              (t) => DropdownMenuItem(value: t, child: Text(t)),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _accountType = v ?? _accountType),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        strings.accountCodeLabel,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          hintText: strings.accountCodeHint,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        strings.currencyLabel,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: _currency,
                        items: currencies
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _currency = v ?? _currency),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        strings.openingBalanceLabel,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _openingBalanceController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          hintText: '0.00',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              RoundedPrimaryButton(
                label: strings.createAccount,
                onPressed: _save,
                fullWidth: true,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    foregroundColor: theme.colorScheme.onSurface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    strings.cancel,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
