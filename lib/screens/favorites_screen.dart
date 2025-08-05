import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';
import 'country_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        final favoriteCountries = provider.allCountries
            .where((c) => provider.isFavorite(c))
            .toList();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
            centerTitle: true,
          ),
          body: favoriteCountries.isEmpty
              ? const Center(child: Text('No favorite countries yet.'))
              : ListView.builder(
                  itemCount: favoriteCountries.length,
                  itemBuilder: (context, index) {
                    final country = favoriteCountries[index];
                    return CountryCard(
                      country: country,
                      isFavorite: true,
                      onFavoriteToggle: (country) => provider.toggleFavorite(country),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CountryDetailScreen(country: country),
                          ),
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
} 