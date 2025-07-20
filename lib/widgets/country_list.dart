import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';
import '../screens/country_detail_screen.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (provider.error != null) {
          return Expanded(
            child: Center(child: Text('Error: ${provider.error}')),
          );
        }
        
        return Expanded(
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
        );
      },
    );
  }
} 