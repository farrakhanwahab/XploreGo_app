import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/country_provider.dart';
import '../models/country.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                      prefixIcon: const Icon(LucideIcons.search),
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