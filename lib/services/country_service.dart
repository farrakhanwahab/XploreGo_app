import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class CountryService {
  static const String _baseUrl = 'https://restcountries.com/v3.1/all?fields=name,flags,capital,continents,population,currencies,languages';

  static Future<List<Country>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> fetchStapleFood(String countryName) async {
    final cuisineTitle = 'Cuisine_of_${countryName.replaceAll(' ', '_')}';
    final url = 'https://en.wikipedia.org/api/rest_v1/page/summary/$cuisineTitle';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['extract'] != null && data['extract'].toString().isNotEmpty) {
          return data['extract'];
        }
      }
    } catch (e) {
      // ignore
    }
    return null;
  }
} 