import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';

class ContinentFilterModal {
  static void show(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final continents = provider.allContinents;
        final selectedContinents = Set<String>.from(provider.selectedContinents);
        
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.public, color: colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            'Filter by Continent',
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
                      color: colorScheme.outline.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Continent Options
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: continents.map((continent) => FilterChip(
                      label: Text(
                        continent,
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedContinents.contains(continent) 
                              ? colorScheme.onPrimary 
                              : colorScheme.onSurface,
                          fontWeight: selectedContinents.contains(continent) 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                        ),
                      ),
                      selected: selectedContinents.contains(continent),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedContinents.add(continent);
                          } else {
                            selectedContinents.remove(continent);
                          }
                        });
                      },
                      backgroundColor: colorScheme.surfaceVariant,
                      selectedColor: colorScheme.primary,
                      checkmarkColor: colorScheme.onPrimary,
                      side: BorderSide(
                        color: selectedContinents.contains(continent) 
                            ? colorScheme.primary 
                            : colorScheme.outline.withOpacity(0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: selectedContinents.contains(continent) ? 1 : 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    )).toList(),
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
                              continents: selectedContinents,
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 