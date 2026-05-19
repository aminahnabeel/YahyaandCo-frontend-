import 'package:flutter/material.dart';
import '../theme.dart';
import 'add_account.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final accounts = [
      {
        'name': 'Main Bank Account',
        'type': 'Bank',
        'amount': '₹245,300',
        'positive': true,
      },
      {
        'name': 'Cash in Hand',
        'type': 'Cash',
        'amount': '₹45,200',
        'positive': true,
      },
      {
        'name': 'Customer Accounts',
        'type': 'Receivable',
        'amount': '₹125,400',
        'positive': true,
      },
      {
        'name': 'Supplier Accounts',
        'type': 'Payable',
        'amount': '-₹89,200',
        'positive': false,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.separated(
              itemCount: accounts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (ctx, i) {
                final a = accounts[i];
                final positive = a['positive'] as bool;
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      a['name'] as String,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text(
                        a['type'] as String,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    trailing: Text(
                      a['amount'] as String,
                      style: TextStyle(
                        color: positive
                            ? AppTheme.success
                            : Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (_) => const AddAccountPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
