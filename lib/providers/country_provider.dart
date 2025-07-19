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

  List<Country> get countries => _filteredCountries;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;
  Set<String> get favoriteCountryNames => _favoriteCountryNames;

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

  // Add filter methods for continent, population, language as needed
} 