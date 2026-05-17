import 'package:flutter/material.dart';

class DashboardStatDetailScreen extends StatelessWidget {
  final String title;
  final String amount;
  final String change;
  final Color accentColor;

  const DashboardStatDetailScreen({
    super.key,
    required this.title,
    required this.amount,
    required this.change,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        amount,
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.22),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            change,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: accentColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text('Breakdown', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Expanded(
                child: ListView(
                  children: List.generate(
                    4,
                    (i) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.surface,
                        child: Text('${i + 1}'),
                      ),
                      title: Text('Sample item ${i + 1}'),
                      subtitle: Text('Details about item ${i + 1}'),
                      trailing: Text(
                        '₹${(i + 1) * 10}K',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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
