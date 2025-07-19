import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../models/country.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openFilterModal(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final continents = provider.allContinents;
        final languages = provider.allLanguages;
        final currencies = provider.allCurrencies;
        final selectedContinents = Set<String>.from(provider.selectedContinents);
        final selectedLanguages = Set<String>.from(provider.selectedLanguages);
        final selectedCurrencies = Set<String>.from(provider.selectedCurrencies);
        return StatefulBuilder(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Continent'),
                  Wrap(
                    spacing: 8,
                    children: continents.map((c) => FilterChip(
                      label: Text(c),
                      selected: selectedContinents.contains(c),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedContinents.add(c);
                          } else {
                            selectedContinents.remove(c);
                          }
                        });
                      },
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Language'),
                  Wrap(
                    spacing: 8,
                    children: languages.map((l) => FilterChip(
                      label: Text(l),
                      selected: selectedLanguages.contains(l),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedLanguages.add(l);
                          } else {
                            selectedLanguages.remove(l);
                          }
                        });
                      },
                    )).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Text('Currency'),
                  Wrap(
                    spacing: 8,
                    children: currencies.map((cur) => FilterChip(
                      label: Text(cur),
                      selected: selectedCurrencies.contains(cur),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedCurrencies.add(cur);
                          } else {
                            selectedCurrencies.remove(cur);
                          }
                        });
                      },
                    )).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            selectedContinents.clear();
                            selectedLanguages.clear();
                            selectedCurrencies.clear();
                          });
                          provider.clearFiltersAndSort();
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          provider.setFiltersAndSort(
                            continents: selectedContinents,
                            languages: selectedLanguages,
                            currencies: selectedCurrencies,
                          );
                          Navigator.pop(context);
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _openSortModal(BuildContext context) {
    final provider = Provider.of<CountryProvider>(context, listen: false);
    String sort = provider.sort;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sort', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<String>(
                    title: const Text('Name (A–Z)'),
                    value: 'Name (A–Z)',
                    groupValue: sort,
                    onChanged: (v) => setState(() => sort = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Name (Z–A)'),
                    value: 'Name (Z–A)',
                    groupValue: sort,
                    onChanged: (v) => setState(() => sort = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Population (ascending)'),
                    value: 'Population (asc)',
                    groupValue: sort,
                    onChanged: (v) => setState(() => sort = v!),
                  ),
                  RadioListTile<String>(
                    title: const Text('Population (descending)'),
                    value: 'Population (desc)',
                    groupValue: sort,
                    onChanged: (v) => setState(() => sort = v!),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            sort = 'Name (A–Z)';
                          });
                          provider.setFiltersAndSort(sort: sort);
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          provider.setFiltersAndSort(sort: sort);
                          Navigator.pop(context);
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('XploreGo'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite),
                  tooltip: 'Favorites',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const FavoritesScreen(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Filter',
                  onPressed: () => _openFilterModal(context),
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  tooltip: 'Sort',
                  onPressed: () => _openSortModal(context),
                ),
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: provider.search,
                    decoration: InputDecoration(
                      hintText: 'Search countries...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                if (provider.isLoading)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (provider.error != null)
                  Expanded(
                    child: Center(child: Text('Error: ${provider.error}')),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.countries.length,
                      itemBuilder: (context, index) {
                        final country = provider.countries[index];
                        return CountryCard(
                          country: country,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CountryDetailScreen(country: country),
                              ),
                            );
                          },
                          isFavorite: provider.isFavorite(country),
                          onFavoriteToggle: () => provider.toggleFavorite(country),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
      },
    );
  }
} 