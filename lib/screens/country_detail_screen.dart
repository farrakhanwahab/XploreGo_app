import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import '../models/country.dart';
import '../providers/country_provider.dart';
import '../utils/snackbar_utils.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;
  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        // Always get the latest country object from the provider by name
        final latestCountry = provider.countries.firstWhere(
          (c) => c.name == country.name,
          orElse: () => country,
        );
        final isFavorite = provider.isFavorite(latestCountry);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, size: 32),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(country.name),
            centerTitle: true,
            actions: [
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: isFavorite ? Colors.red : colorScheme.onSurface,
                    size: 28,
                  ),
                ),
                onPressed: () {
                  final wasAdded = provider.toggleFavorite(country);
                  SnackbarUtils.showFavoriteMessage(context, country.name, wasAdded);
                },
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flag and name section
                Center(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.shadow.withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          border: Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.3),
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: country.flagUrl,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Lottie.asset(
                                    'assets/animations/loading.json',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.contain,
                                    repeat: true,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.flag, color: Colors.grey, size: 48),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        latestCountry.name,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                
                // Basic info card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basic Information',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(context, Icons.location_city, 'Capital', country.capital, colorScheme),
                        const SizedBox(height: 12),
                        _buildInfoRow(context, Icons.public, 'Continent', country.continent, colorScheme),
                        const SizedBox(height: 12),
                        _buildInfoRow(context, Icons.people, 'Population', country.population.toString(), colorScheme),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Currency and languages card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Currency & Languages',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(context, Icons.attach_money, 'Currency', '${country.currencyName} (${country.currencySymbol})', colorScheme),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.language, size: 20, color: colorScheme.secondary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Languages',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    country.languages.join(", "),
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: colorScheme.onSurface,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Staple food section (if available)
                if (latestCountry.stapleFood != null && latestCountry.stapleFood!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cuisine',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(context, Icons.restaurant, 'Staple Food', latestCountry.stapleFood!, colorScheme),
                        ],
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(icon, size: 20, color: colorScheme.secondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 