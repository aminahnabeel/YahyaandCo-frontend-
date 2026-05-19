import 'package:flutter/material.dart';
import 'dashboard.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  final List<_BusinessItem> _businesses = [
    const _BusinessItem('Acme Corporation', 'Service Business'),
    const _BusinessItem('Tech Solutions Ltd', 'Tech Business'),
    const _BusinessItem('Green Enterprises', 'Trading Business'),
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  int? _selectedIndex;
  int? _hoveredIndex;

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _openAddBusinessSheet() {
    _nameController.clear();
    _typeController.clear();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) {
        final bottomInset = MediaQuery.of(sheetContext).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Business',
                textAlign: TextAlign.center,
                style: Theme.of(sheetContext).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Business name',
                  prefixIcon: Icon(Icons.business_outlined),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Business type',
                  prefixIcon: Icon(Icons.category_outlined),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text.trim();
                  final type = _typeController.text.trim();

                  if (name.isEmpty || type.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Enter both name and business type.'),
                      ),
                    );
                    return;
                  }

                  setState(() {
                    _businesses.add(_BusinessItem(name, type));
                  });
                  Navigator.of(sheetContext).pop();
                },
                child: const Text('Save Business'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 92),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 640),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            'Select Business',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Choose a business to manage',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 18),
                          ..._businesses.asMap().entries.map((entry) {
                            final business = entry.value;

                            final bool isSelected = _selectedIndex == entry.key;
                            final bool isHovered = _hoveredIndex == entry.key;

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: entry.key == _businesses.length - 1
                                    ? 0
                                    : 12,
                              ),
                              child: MouseRegion(
                                onEnter: (_) =>
                                    setState(() => _hoveredIndex = entry.key),
                                onExit: (_) =>
                                    setState(() => _hoveredIndex = null),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() => _selectedIndex = entry.key);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => DashboardMainScreen(
                                          businessName: business.name,
                                        ),
                                      ),
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    curve: Curves.easeOut,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 18,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? colors.primary.withAlpha(
                                              (0.06 * 255).round(),
                                            )
                                          : isHovered
                                          ? colors.surfaceContainerHighest
                                                .withAlpha((0.04 * 255).round())
                                          : colors.surface,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: isSelected || isHovered
                                          ? [
                                              BoxShadow(
                                                color: colors.shadow.withAlpha(
                                                  (0.08 * 255).round(),
                                                ),
                                                blurRadius: 14,
                                                offset: const Offset(0, 6),
                                              ),
                                            ]
                                          : [
                                              BoxShadow(
                                                color: colors.shadow.withAlpha(
                                                  (0.02 * 255).round(),
                                                ),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                      border: Border.all(
                                        color: isSelected
                                            ? colors.primary
                                            : colors.outlineVariant.withAlpha(
                                                (0.45 * 255).round(),
                                              ),
                                        width: isSelected ? 1.6 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          business.name,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: isSelected
                                                    ? colors.primary
                                                    : null,
                                              ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          business.type,
                                          style: theme.textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: FloatingActionButton(
                    onPressed: _openAddBusinessSheet,
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BusinessItem {
  const _BusinessItem(this.name, this.type);

  final String name;
  final String type;
}
