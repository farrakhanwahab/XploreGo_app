import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';

class SortModal {
  static void show(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    String sort = provider.sort;
    final colorScheme = Theme.of(context).colorScheme;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
                      Text(
                        'Sort Options',
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
                      color: colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Sort Options
                  Card(
                    elevation: 0,
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Name (A–Z)'),
                          value: 'Name (A–Z)',
                          groupValue: sort,
                          onChanged: (v) => setState(() => sort = v!),
                          activeColor: colorScheme.primary,
                        ),
                        RadioListTile<String>(
                          title: const Text('Name (Z–A)'),
                          value: 'Name (Z–A)',
                          groupValue: sort,
                          onChanged: (v) => setState(() => sort = v!),
                          activeColor: colorScheme.primary,
                        ),
                        RadioListTile<String>(
                          title: const Text('Population (ascending)'),
                          value: 'Population (asc)',
                          groupValue: sort,
                          onChanged: (v) => setState(() => sort = v!),
                          activeColor: colorScheme.primary,
                        ),
                        RadioListTile<String>(
                          title: const Text('Population (descending)'),
                          value: 'Population (desc)',
                          groupValue: sort,
                          onChanged: (v) => setState(() => sort = v!),
                          activeColor: colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              sort = 'Name (A–Z)';
                            });
                            provider.setFiltersAndSort(sort: sort);
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Reset'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            provider.setFiltersAndSort(sort: sort);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Apply Sort'),
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