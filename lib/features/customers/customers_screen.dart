import 'package:flutter/material.dart';
import '../../widgets/hoverable_card.dart';

class CustomersScreen extends StatelessWidget {
  const CustomersScreen({super.key});

  Widget _customerCard(BuildContext context, String name, String subtitle) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    String initials(String n) {
      final parts = n.split(' ');
      if (parts.isEmpty) return '';
      if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return HoverableCard(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: cs.primaryContainer,
              child: Text(
                initials(name),
                style: textTheme.titleMedium?.copyWith(
                  color: cs.onPrimaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text('Active', style: textTheme.labelSmall),
                        backgroundColor: cs.primary.withValues(alpha: 0.08),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹24,000 due',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit, color: cs.primary),
                  tooltip: 'Edit',
                ),
                const SizedBox(height: 4),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: cs.onSurfaceVariant),
                  tooltip: 'More',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sample = [
      ['ABC Corporation', 'contact@abccorp.com'],
      ['XYZ Trading Ltd', 'hello@xyztrading.com'],
      ['Tech Solutions Inc', 'info@techsol.com'],
      ['Global Traders', 'sales@globaltraders.com'],
      ['Fresh Foods Co', 'orders@freshfoods.com'],
      ['Bright Lighting', 'support@brightlight.com'],
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          int cols = 1;
          if (width >= 1200) {
            cols = 4;
          } else if (width >= 900) {
            cols = 3;
          } else if (width >= 600) {
            cols = 2;
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: width < 600 ? 3.2 : 2.6,
              ),
              itemCount: sample.length,
              itemBuilder: (context, i) {
                final row = sample[i];
                return _customerCard(context, row[0], row[1]);
              },
            ),
          );
        },
      ),
    );
  }
}
