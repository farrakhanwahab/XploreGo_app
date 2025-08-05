import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../widgets/country_card.dart';
import '../screens/country_detail_screen.dart';
import 'package:lottie/lottie.dart';

class CountryList extends StatelessWidget {
  const CountryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Expanded(
            child: Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  repeat: true,
                ),
              ),
            ),
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
                onFavoriteToggle: (country) => provider.toggleFavorite(country),
              );
            },
          ),
        );
      },
    );
  }
} 