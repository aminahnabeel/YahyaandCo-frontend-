import 'package:flutter/material.dart';
import '../../state/business_workspace_controller.dart';

class ManageBusinessesPage extends StatefulWidget {
  const ManageBusinessesPage({super.key});

  @override
  State<ManageBusinessesPage> createState() => _ManageBusinessesPageState();
}

class _ManageBusinessesPageState extends State<ManageBusinessesPage> {
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

    if (res != null) {
      businessWorkspaceController.addBusiness(
        name: res['name']?.trim() ?? '',
        type: res['role']?.trim().isNotEmpty == true
            ? res['role']!.trim()
            : 'General Business',
      );
      setState(() {});
    }
  }

  void _removeBusiness(int idx) {
    final businesses = businessWorkspaceController.businesses;
    if (idx < 0 || idx >= businesses.length) return;
    final business = businesses[idx];
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Remove business'),
        content: const Text('Are you sure you want to remove this business from your account?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              businessWorkspaceController.removeBusiness(business.id);
              setState(() {});
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
    return ValueListenableBuilder<BusinessWorkspaceState>(
      valueListenable: businessWorkspaceController,
      builder: (context, state, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Manage Businesses')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.45),
                    ),
                    child: Text(
                      '${state.businesses.length} businesses available',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: state.businesses.isEmpty
                        ? Center(
                            child: Text(
                              'No businesses yet',
                              style: theme.textTheme.bodyLarge,
                            ),
                          )
                        : ListView.separated(
                            itemCount: state.businesses.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 10),
                            itemBuilder: (ctx, i) {
                              final business = state.businesses[i];
                              final selected =
                                  business.id == state.selectedBusinessId;
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(business.shortCode),
                                  ),
                                  title: Text(business.name),
                                  subtitle: Text(business.type),
                                  selected: selected,
                                  trailing: PopupMenuButton<String>(
                                    onSelected: (v) {
                                      if (v == 'remove') _removeBusiness(i);
                                    },
                                    itemBuilder: (_) => [
                                      const PopupMenuItem(
                                        value: 'remove',
                                        child: Text('Remove'),
                                      ),
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
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
