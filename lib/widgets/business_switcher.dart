import 'package:flutter/material.dart';

import '../state/business_workspace_controller.dart';

class BusinessSwitcher extends StatelessWidget {
  const BusinessSwitcher({
    super.key,
    this.compact = false,
    this.showLabel = true,
  });

  final bool compact;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BusinessWorkspaceState>(
      valueListenable: businessWorkspaceController,
      builder: (context, state, _) {
        final business = state.selectedBusiness;
        final theme = Theme.of(context);
        final card = Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(compact ? 14 : 18),
          child: InkWell(
            borderRadius: BorderRadius.circular(compact ? 14 : 18),
            onTap: () => _openSwitcherSheet(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: compact ? 14 : 16,
                vertical: compact ? 12 : 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(compact ? 14 : 18),
                border: Border.all(
                  color: business.accentColor.withValues(alpha: 0.18),
                ),
                gradient: LinearGradient(
                  colors: [
                    business.accentColor.withValues(alpha: 0.10),
                    theme.colorScheme.surface,
                  ],
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: compact ? 18 : 22,
                    backgroundColor: business.accentColor.withValues(alpha: 0.16),
                    child: Text(
                      business.shortCode,
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: business.accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (showLabel)
                          Text(
                            'Current business',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          ),
                        Text(
                          business.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          business.type,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ],
              ),
            ),
          ),
        );

        return card;
      },
    );
  }

  Future<void> _openSwitcherSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ValueListenableBuilder<BusinessWorkspaceState>(
              valueListenable: businessWorkspaceController,
              builder: (context, state, _) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Switch business',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose the workspace whose data you want to view.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.7),
                          ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 420),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.businesses.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final business = state.businesses[index];
                          final selected = business.id == state.selectedBusinessId;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: selected
                                    ? business.accentColor
                                    : Theme.of(context)
                                        .colorScheme
                                        .outline
                                        .withValues(alpha: 0.15),
                              ),
                              color: selected
                                  ? business.accentColor.withValues(alpha: 0.08)
                                  : Theme.of(context).colorScheme.surface,
                            ),
                            child: ListTile(
                              onTap: () {
                                businessWorkspaceController.selectBusiness(
                                  business.id,
                                );
                                Navigator.of(sheetContext).pop();
                              },
                              leading: CircleAvatar(
                                backgroundColor:
                                    business.accentColor.withValues(alpha: 0.16),
                                child: Text(
                                  business.shortCode,
                                  style: TextStyle(color: business.accentColor),
                                ),
                              ),
                              title: Text(
                                business.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(business.type),
                              trailing: selected
                                  ? Icon(
                                      Icons.check_circle,
                                      color: business.accentColor,
                                    )
                                  : const Icon(Icons.chevron_right),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}