import 'package:flutter/material.dart';

class ManageBusinessesPage extends StatefulWidget {
  const ManageBusinessesPage({super.key});

  @override
  State<ManageBusinessesPage> createState() => _ManageBusinessesPageState();
}

class _ManageBusinessesPageState extends State<ManageBusinessesPage> {
  final List<Map<String, String>> _businesses = [
    {'name': 'Baba Grocers', 'role': 'Owner'},
    {'name': 'Yahya Traders', 'role': 'Admin'},
  ];

  void _addBusiness() async {
    final res = await showDialog<Map<String, String>>(
      context: context,
      builder: (ctx) {
        final nameCtrl = TextEditingController();
        final roleCtrl = TextEditingController();
        return AlertDialog(
          title: const Text('Add Business'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Business name')),
              TextField(controller: roleCtrl, decoration: const InputDecoration(labelText: 'Your role')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.trim().isEmpty) return;
                Navigator.of(ctx).pop({'name': nameCtrl.text.trim(), 'role': roleCtrl.text.trim()});
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (res != null) setState(() => _businesses.add(res));
  }

  void _removeBusiness(int idx) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove business'),
        content: const Text('Are you sure you want to remove this business from your account?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() => _businesses.removeAt(idx));
              Navigator.of(ctx).pop();
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Businesses')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: _businesses.isEmpty
                    ? Center(
                        child: Text('No businesses yet', style: theme.textTheme.bodyLarge),
                      )
                    : ListView.separated(
                        itemCount: _businesses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (ctx, i) {
                          final b = _businesses[i];
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              leading: CircleAvatar(child: Text(b['name']!.substring(0, 1))),
                              title: Text(b['name']!),
                              subtitle: Text(b['role'] ?? ''),
                              trailing: PopupMenuButton<String>(
                                onSelected: (v) {
                                  if (v == 'remove') _removeBusiness(i);
                                },
                                itemBuilder: (_) => [
                                  const PopupMenuItem(value: 'remove', child: Text('Remove')),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_business),
                  label: const Text('Add Business'),
                  onPressed: _addBusiness,
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
