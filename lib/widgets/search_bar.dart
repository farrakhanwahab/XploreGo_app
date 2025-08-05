import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import 'sort_modal.dart';

class CountrySearchBar extends StatefulWidget {
  const CountrySearchBar({super.key});

  @override
  State<CountrySearchBar> createState() => CountrySearchBarState();
}

class CountrySearchBarState extends State<CountrySearchBar> {
  late TextEditingController _searchController;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<CountryProvider>(context, listen: false);
    if (_searchController.text != provider.searchQuery) {
      _searchController.text = provider.searchQuery;
    }
  }

  @override
  void dispose() {
    _searchController.clear();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void clearSearch() {
    _searchController.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Consumer<CountryProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Search field (reduced width)
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  onChanged: (value) {
                    provider.search(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search countries...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Sort button
              IconButton(
                onPressed: () => SortModal.show(context),
                icon: Icon(
                  Icons.tune,
                  color: colorScheme.primary,
                ),
                tooltip: 'Sort',
              ),
            ],
          ),
        );
      },
    );
  }
} 