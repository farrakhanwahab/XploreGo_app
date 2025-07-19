import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/country_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';
  Set<String> _favoriteCountryNames = {};

  // Filter and sort state
  Set<String> _selectedContinents = {};
  Set<String> _selectedLanguages = {};
  Set<String> _selectedCurrencies = {};
  String _sort = 'Name (A–Z)';

  List<Country> get countries => _filteredCountries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Set<String> get favoriteCountryNames => _favoriteCountryNames;

  Set<String> get selectedContinents => _selectedContinents;
  Set<String> get selectedLanguages => _selectedLanguages;
  Set<String> get selectedCurrencies => _selectedCurrencies;
  String get sort => _sort;

  CountryProvider() {
    fetchCountries();
    _loadFavorites();
  }

  Future<void> fetchCountries() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final countries = await CountryService.fetchCountries();
      _countries = countries;
      _filteredCountries = _countries;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredCountries = _countries;
    } else {
      _filteredCountries = _countries.where((country) =>
        country.name.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteCountryNames = prefs.getStringList('favorites')?.toSet() ?? {};
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteCountryNames.toList());
  }

  void toggleFavorite(Country country) {
    if (_favoriteCountryNames.contains(country.name)) {
      _favoriteCountryNames.remove(country.name);
    } else {
      _favoriteCountryNames.add(country.name);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Country country) => _favoriteCountryNames.contains(country.name);

  void setFiltersAndSort({
    Set<String>? continents,
    Set<String>? languages,
    Set<String>? currencies,
    String? sort,
  }) {
    _selectedContinents = continents ?? _selectedContinents;
    _selectedLanguages = languages ?? _selectedLanguages;
    _selectedCurrencies = currencies ?? _selectedCurrencies;
    _sort = sort ?? _sort;
    _applyFiltersAndSort();
    notifyListeners();
  }

  void clearFiltersAndSort() {
    _selectedContinents.clear();
    _selectedLanguages.clear();
    _selectedCurrencies.clear();
    _sort = 'Name (A–Z)';
    _applyFiltersAndSort();
    notifyListeners();
  }

  void _applyFiltersAndSort() {
    List<Country> filtered = _countries;
    if (_selectedContinents.isNotEmpty) {
      filtered = filtered.where((c) => _selectedContinents.contains(c.continent)).toList();
    }
    if (_selectedLanguages.isNotEmpty) {
      filtered = filtered.where((c) => c.languages.any(_selectedLanguages.contains)).toList();
    }
    if (_selectedCurrencies.isNotEmpty) {
      filtered = filtered.where((c) => _selectedCurrencies.contains(c.currencySymbol) || _selectedCurrencies.contains(c.currencyName)).toList();
    }
    // Sort
    switch (_sort) {
      case 'Name (A–Z)':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Name (Z–A)':
        filtered.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Population (asc)':
        filtered.sort((a, b) => a.population.compareTo(b.population));
        break;
      case 'Population (desc)':
        filtered.sort((a, b) => b.population.compareTo(a.population));
        break;
    }
    _filteredCountries = filtered;
  }

  // Utility to get all unique values for filter chips
  List<String> get allContinents => _countries.map((c) => c.continent).toSet().toList()..sort();
  List<String> get allLanguages => _countries.expand((c) => c.languages).toSet().toList()..sort();
  List<String> get allCurrencies => _countries.map((c) => c.currencySymbol).toSet().toList()..sort();
} 