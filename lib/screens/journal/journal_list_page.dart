import 'package:flutter/material.dart';

import '../starting/language/app_language.dart';
import '../../widgets/appbar.dart';
import 'journal_details_page.dart';
import 'journal_entry.dart';

class JournalListPage extends StatefulWidget {
  const JournalListPage({super.key});

  @override
  State<JournalListPage> createState() => _JournalListPageState();
}

class _JournalListPageState extends State<JournalListPage> {
  late List<Map<String, dynamic>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = [
      {
        'voucher': 'JV-1',
        'date': '2024-05-01',
        'desc': 'Opening entry',
        'amount': '50,000',
      },
      {
        'voucher': 'CP-1',
        'date': '2024-05-10',
        'desc': 'Cash payment',
        'amount': '20,000',
      },
      {
        'voucher': 'CR-1',
        'date': '2024-05-12',
        'desc': 'Customer receipt',
        'amount': '10,000',
      },
    ];
  }

  Future<void> _openJournalEntry() async {
    final result = await Navigator.of(context).push<Map<String, dynamic>>(
      MaterialPageRoute(builder: (_) => const JournalEntryPage()),
    );

    if (result == null) return;

    setState(() {
      final type = (result['voucherType'] ?? '') as String;
      String prefix = 'JV';
      if (type == 'Cash Payment') prefix = 'CP';

      final count = _entries
          .where((e) => (e['voucher'] as String).startsWith(prefix))
          .length;

      final date = result['date'] as DateTime?;
      _entries.add({
        'voucher': '$prefix-${count + 1}',
        'date':
            date == null
                ? DateTime.now().toIso8601String().split('T').first
                : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
        'desc': (result['description'] as String?)?.trim().isNotEmpty == true
            ? (result['description'] as String).trim()
            : 'Journal Entry',
        'amount': '0',
      });
    });
  }

  Future<void> _confirmDelete(int index) async {
    final strings = appLanguageController.strings;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(appLanguageController.tr('Delete entry')),
          content: Text(
            appLanguageController.tr(
              'Are you sure you want to delete this journal entry?',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(strings.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(appLanguageController.tr('Delete')),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      setState(() => _entries.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = appLanguageController.strings;

    return Scaffold(
      appBar: CustomAppBar(
        title: strings.journalListTitle,
        onBackPressed: () => Navigator.of(context).pop(),
        showTitle: true,
      ),
      body: SafeArea(
        child: _entries.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      appLanguageController.tr('No journal entries'),
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: _entries.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (ctx, i) {
                  final entry = _entries[i];
                  return ListTile(
                    title: Text(
                      '${entry['voucher']} - ${entry['desc']}',
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(entry['date']?.toString() ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entry['amount']?.toString() ?? '',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            color: theme.colorScheme.error,
                          ),
                          tooltip: appLanguageController.tr('Delete'),
                          onPressed: () => _confirmDelete(i),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(ctx).push(
                        MaterialPageRoute(
                          builder: (_) => JournalDetailsPage(entry: entry),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openJournalEntry,
        icon: const Icon(Icons.add),
        label: Text(strings.journalEntry),
      ),
    );
  }
}
