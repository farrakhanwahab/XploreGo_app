import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';

class CurrencyFilterModal {
  static void show(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final currencies = provider.allCurrencies;
        final selectedCurrencies = Set<String>.from(provider.selectedCurrencies);
        
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: StatefulBuilder(
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Fixed Header
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 52,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.attach_money, color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Filter by Currency',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: colorScheme.onSurface,
                                    ),
                              ),
                            ],
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
                          color: colorScheme.outline.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                
                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Currency Options
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: currencies.map((currency) => FilterChip(
                            label: Text(
                              currency,
                              style: TextStyle(
                                fontSize: 14,
                                color: selectedCurrencies.contains(currency) 
                                    ? colorScheme.onPrimary 
                                    : colorScheme.onSurface,
                                fontWeight: selectedCurrencies.contains(currency) 
                                    ? FontWeight.w600 
                                    : FontWeight.normal,
                              ),
                            ),
                            selected: selectedCurrencies.contains(currency),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedCurrencies.add(currency);
                                } else {
                                  selectedCurrencies.remove(currency);
                                }
                              });
                            },
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            selectedColor: colorScheme.primary,
                            checkmarkColor: colorScheme.onPrimary,
                            side: BorderSide(
                                      color: selectedCurrencies.contains(currency) 
            ? colorScheme.primary 
            : colorScheme.outline.withValues(alpha: 0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: selectedCurrencies.contains(currency) ? 1 : 0,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          )).toList(),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                
                // Fixed Action Buttons
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              selectedCurrencies.clear();
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            provider.setFiltersAndSort(
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
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 