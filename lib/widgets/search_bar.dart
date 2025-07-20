import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import 'sort_modal.dart';

class CountrySearchBar extends StatelessWidget {
  const CountrySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Search field (reduced width)
              Expanded(
                flex: 3,
                child: TextField(
                  onChanged: provider.search,
                  decoration: InputDecoration(
                    hintText: 'Search countries...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sort button
              IconButton(
                onPressed: () => SortModal.show(context),
                icon: Icon(
                  Icons.tune,
                  color: colorScheme.primary,
                ),
                tooltip: 'Sort',
              ),
            ],
          ),
        );
      },
    );
  }
} 