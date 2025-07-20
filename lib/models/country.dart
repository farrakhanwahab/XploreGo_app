class Country {
  final String name;
  final String flagUrl;
  final String capital;
  final String continent;
  final int population;
  final String currencyName;
  final String currencySymbol;
  final List<String> languages;
  final String? stapleFood;

  Country({
    required this.name,
    required this.flagUrl,
    required this.capital,
    required this.continent,
    required this.population,
    required this.currencyName,
    required this.currencySymbol,
    required this.languages,
    this.stapleFood,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    // Parse languages
    final languages = <String>[];
    if (json['languages'] is Map) {
      (json['languages'] as Map).forEach((key, value) {
        languages.add(value);
      });
    }
    // Parse currency
    String currencyName = '';
    String currencySymbol = '';
    if (json['currencies'] is Map && (json['currencies'] as Map).isNotEmpty) {
      final currency = (json['currencies'] as Map).values.first;
      currencyName = currency['name'] ?? '';
      currencySymbol = currency['symbol'] ?? '';
    }
    return Country(
      name: json['name']?['common'] ?? '',
      flagUrl: json['flags']?['png'] ?? '',
      capital: (json['capital'] != null && json['capital'] is List && (json['capital'] as List).isNotEmpty) ? json['capital'][0] : '',
      continent: (json['continents'] != null && json['continents'] is List && (json['continents'] as List).isNotEmpty) ? json['continents'][0] : '',
      population: json['population'] ?? 0,
      currencyName: currencyName,
      currencySymbol: currencySymbol,
      languages: languages,
      stapleFood: null, // To be filled from MediaWiki API
    );
  }
} 