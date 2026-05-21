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
  String _accountType = 'Asset';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _openingBalanceController =
      TextEditingController();

  final Color _navy = const Color(0xFF09263A);

  @override
  void initState() {
    super.initState();
    _openingBalanceController.text = '0.00';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _openingBalanceController.dispose();
    super.dispose();
  }

  void _save() {
    final data = {
      'accountType': _accountType,
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'openingBalance': _openingBalanceController.text,
    };
    Navigator.of(context).pop(data);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;
    final accountTypes = [
      'Asset',
      'Liability',
      'Income',
      'Expense',
      'Cash',
      'Bank',
    ];

    InputDecoration fieldDecoration({String? hint, String? label}) => InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13, color: Colors.black87),
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 18),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.4),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: _navy, width: 2),
          ),
        );

    return Scaffold(
      appBar: CustomAppBar(
        title: strings.addAccountTitle,
        onBackPressed: () => Navigator.of(context).pop(),
        showTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Account Name
              TextField(
                controller: _nameController,
                decoration: fieldDecoration(hint: 'Account Name'),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 18),

              // Account Type label + dropdown (styled large)
              DropdownButtonFormField<String>(
                value: _accountType,
                items: accountTypes
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (v) => setState(() => _accountType = v ?? _accountType),
                decoration: fieldDecoration(label: 'Account Type'),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                icon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 18),

              // Phone
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: fieldDecoration(hint: 'Phone'),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 18),

              // Address
              TextField(
                controller: _addressController,
                decoration: fieldDecoration(hint: 'Address'),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 18),

              // Opening Balance
              TextField(
                controller: _openingBalanceController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: fieldDecoration(hint: 'Opening Balance'),
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 26),
              RoundedPrimaryButton(
                label: 'Save Account',
                onPressed: _save,
                fullWidth: true,
                backgroundColor: _navy,
                height: 56,
                elevation: 6,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
