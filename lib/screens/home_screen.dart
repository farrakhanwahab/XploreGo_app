import 'package:flutter/material.dart';
import '../widgets/search_bar.dart' as search_widget;
import '../widgets/filter_chips.dart';
import '../widgets/country_list.dart';
import '../widgets/filter_fab.dart';
import '../widgets/navbar.dart';
import 'favorites_screen.dart';
import 'settings_screen.dart';
import '../providers/country_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  final GlobalKey<_HomeContentState> _homeContentKey = GlobalKey<_HomeContentState>();

  final List<Widget> _screens = [
    _HomeContent(key: GlobalKey<_HomeContentState>()),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Clear search when navigating away from home tab
          if (index != 0) {
            final provider = Provider.of<CountryProvider>(context, listen: false);
            provider.search('');
            // Unfocus any active text fields
            FocusScope.of(context).unfocus();
          }
        },
        children: _screens,
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          // Clear search when navigating away from home tab
          if (index != 0) {
            final provider = Provider.of<CountryProvider>(context, listen: false);
            provider.search('');
            // Unfocus any active text fields
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}

class _HomeContent extends StatefulWidget {
  const _HomeContent({super.key});

  @override
  State<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<_HomeContent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XploreGo'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        toolbarHeight: 44,
      ),
      body: Column(
        children: [
          const search_widget.CountrySearchBar(),
          const FilterChips(),
          const SizedBox(height: 16),
          const CountryList(),
        ],
      ),
      floatingActionButton: const FilterFAB(),
    );
  }
} 