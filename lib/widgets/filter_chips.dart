import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import 'continent_filter_modal.dart';
import 'language_filter_modal.dart';
import 'currency_filter_modal.dart';

class FilterChips extends StatelessWidget {
  const FilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        final hasActiveFilters = provider.selectedContinents.isNotEmpty ||
            provider.selectedLanguages.isNotEmpty ||
            provider.selectedCurrencies.isNotEmpty;

        if (!hasActiveFilters) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Continent Filter Chip
                  if (provider.selectedContinents.isNotEmpty)
                    _buildFilterChip(
                      context,
                      icon: Icons.public,
                      label: _getFilterLabel(provider.selectedContinents, 'All Continents'),
                      onTap: () => ContinentFilterModal.show(context),
                      onClear: () => provider.setFiltersAndSort(continents: {}),
                    ),
                  
                  // Language Filter Chip
                  if (provider.selectedLanguages.isNotEmpty)
                    _buildFilterChip(
                      context,
                      icon: Icons.language,
                      label: _getFilterLabel(provider.selectedLanguages, 'All Languages'),
                      onTap: () => LanguageFilterModal.show(context),
                      onClear: () => provider.setFiltersAndSort(languages: {}),
                    ),
                  
                  // Currency Filter Chip
                  if (provider.selectedCurrencies.isNotEmpty)
                    _buildFilterChip(
                      context,
                      icon: Icons.attach_money,
                      label: _getFilterLabel(provider.selectedCurrencies, 'All Currencies'),
                      onTap: () => CurrencyFilterModal.show(context),
                      onClear: () => provider.setFiltersAndSort(currencies: {}),
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(width: 4),
            InkWell(
              onTap: onClear,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFilterLabel(Set<String> selected, String defaultLabel) {
    if (selected.isEmpty) return defaultLabel;
    if (selected.length == 1) return selected.first;
    if (selected.length <= 3) return selected.join(', ');
    return '${selected.take(2).join(', ')} +${selected.length - 2}';
  }
} 