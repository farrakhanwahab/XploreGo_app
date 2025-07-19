import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';

class FilterModal {
  static void show(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final continents = provider.allContinents;
        final languages = provider.allLanguages;
        final currencies = provider.allCurrencies;
        final selectedContinents = Set<String>.from(provider.selectedContinents);
        final selectedLanguages = Set<String>.from(provider.selectedLanguages);
        final selectedCurrencies = Set<String>.from(provider.selectedCurrencies);
        
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close, color: colorScheme.onSurface),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.outline.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Compact Filter Layout
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column - Continent & Language
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildCompactFilterSection(
                                context,
                                'Continent',
                                continents,
                                selectedContinents,
                                (continent, selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedContinents.add(continent);
                                    } else {
                                      selectedContinents.remove(continent);
                                    }
                                  });
                                },
                                colorScheme,
                              ),
                              const SizedBox(height: 16),
                              _buildCompactFilterSection(
                                context,
                                'Language',
                                languages,
                                selectedLanguages,
                                (language, selected) {
                                  setState(() {
                                    if (selected) {
                                      selectedLanguages.add(language);
                                    } else {
                                      selectedLanguages.remove(language);
                                    }
                                  });
                                },
                                colorScheme,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Right Column - Currency
                        Expanded(
                          child: _buildCompactFilterSection(
                            context,
                            'Currency',
                            currencies,
                            selectedCurrencies,
                            (currency, selected) {
                              setState(() {
                                if (selected) {
                                  selectedCurrencies.add(currency);
                                } else {
                                  selectedCurrencies.remove(currency);
                                }
                              });
                            },
                            colorScheme,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                selectedContinents.clear();
                                selectedLanguages.clear();
                                selectedCurrencies.clear();
                              });
                              provider.clearFiltersAndSort();
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Clear All'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              provider.setFiltersAndSort(
                                continents: selectedContinents,
                                languages: selectedLanguages,
                                currencies: selectedCurrencies,
                              );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildCompactFilterSection(
    BuildContext context,
    String title,
    List<String> options,
    Set<String> selected,
    Function(String, bool) onChanged,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: options.map((option) => FilterChip(
            label: Text(
              option,
              style: TextStyle(
                fontSize: 12,
                color: selected.contains(option) 
                    ? colorScheme.onPrimary 
                    : colorScheme.onSurface,
                fontWeight: selected.contains(option) 
                    ? FontWeight.w600 
                    : FontWeight.normal,
              ),
            ),
            selected: selected.contains(option),
            onSelected: (selected) => onChanged(option, selected),
            backgroundColor: colorScheme.surfaceVariant,
            selectedColor: colorScheme.primary,
            checkmarkColor: colorScheme.onPrimary,
            side: BorderSide(
              color: selected.contains(option) 
                  ? colorScheme.primary 
                  : colorScheme.outline.withOpacity(0.3),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: selected.contains(option) ? 1 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          )).toList(),
        ),
      ],
    );
  }
} 