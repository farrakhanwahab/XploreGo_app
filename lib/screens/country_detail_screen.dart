import 'package:flutter/material.dart';
import '../models/country.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(country.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(country.flagUrl),
                backgroundColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              country.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_city, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Capital: ${country.capital}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.public, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Continent: ${country.continent}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.people, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Population: ${country.population.toString()}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.attach_money, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Currency: ${country.currencyName} (${country.currencySymbol})'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.language, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text('Languages: ${country.languages.join(", ")}'),
                ),
              ],
            ),
            if (country.stapleFood != null && country.stapleFood!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.restaurant, size: 18, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text('Staple Food: ${country.stapleFood}'),
                ],
              ),
            ],
            if (country.popularPlaces.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'Popular Places',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Column(
                children: country.popularPlaces.map((place) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: place.imageUrl.isNotEmpty
                        ? Image.network(place.imageUrl, width: 48, height: 48, fit: BoxFit.cover)
                        : const Icon(Icons.image),
                    title: Text(place.name),
                    subtitle: Text(place.description),
                  ),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 