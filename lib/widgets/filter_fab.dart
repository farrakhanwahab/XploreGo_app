import 'package:flutter/material.dart';
import 'continent_filter_modal.dart';
import 'language_filter_modal.dart';
import 'currency_filter_modal.dart';

class FilterFAB extends StatelessWidget {
  const FilterFAB({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return FloatingActionButton(
      onPressed: () => _showFilterMenu(context),
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.primary,
      elevation: 8,
      shape: const CircleBorder(),
      child: const Icon(Icons.filter_list, size: 28),
    );
  }

  void _showFilterMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Title
                  Text(
                    'Filter Options',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Filter Options
                  _buildFilterOption(
                    context,
                    icon: Icons.public,
                    title: 'Filter by Continent',
                    subtitle: 'Select continents to filter countries',
                    onTap: () {
                      Navigator.pop(context);
                      ContinentFilterModal.show(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildFilterOption(
                    context,
                    icon: Icons.language,
                    title: 'Filter by Language',
                    subtitle: 'Select languages to filter countries',
                    onTap: () {
                      Navigator.pop(context);
                      LanguageFilterModal.show(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildFilterOption(
                    context,
                    icon: Icons.attach_money,
                    title: 'Filter by Currency',
                    subtitle: 'Select currencies to filter countries',
                    onTap: () {
                      Navigator.pop(context);
                      CurrencyFilterModal.show(context);
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: colorScheme.onPrimaryContainer,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
} 