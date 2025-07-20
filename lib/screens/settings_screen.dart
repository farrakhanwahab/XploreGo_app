import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _defaultSort = 'Name (A–Z)';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Settings Section
          _buildSectionHeader('App Settings', Icons.settings),
          const SizedBox(height: 16),
          
          // Theme Toggle
          _buildSettingTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Switch between light and dark themes',
            trailing: Switch(
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = value;
                });
                // TODO: Implement theme switching
              },
            ),
          ),
          
          // Default Sort
          _buildSettingTile(
            icon: Icons.sort,
            title: 'Default Sort',
            subtitle: _defaultSort,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showSortOptions(context),
          ),
          
          const SizedBox(height: 24),
          
          // About Section
          _buildSectionHeader('About', Icons.info),
          const SizedBox(height: 16),
          
          // App Version
          _buildSettingTile(
            icon: Icons.app_settings_alt,
            title: 'App Version',
            subtitle: '1.0.0',
          ),
          
          // Privacy Policy
          _buildSettingTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            subtitle: 'Read our privacy policy',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showPrivacyPolicy(context),
          ),
          
          // Terms of Service
          _buildSettingTile(
            icon: Icons.description,
            title: 'Terms of Service',
            subtitle: 'Read our terms of service',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showTermsOfService(context),
          ),
          
          // Contact Us
          _buildSettingTile(
            icon: Icons.contact_support,
            title: 'Contact Us',
            subtitle: 'Get in touch with us',
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showContactUs(context),
          ),
          
          const SizedBox(height: 80),
          
          // App Credits
          Center(
            child: Column(
              children: [
                Text(
                  'Developed by Farrakhan',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Software Engineer | Developer',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
        ),
      ],
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  void _showSortOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Default Sort',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            ...['Name (A–Z)', 'Name (Z–A)', 'Population (asc)', 'Population (desc)']
                .map((sort) => RadioListTile<String>(
                      title: Text(sort),
                      value: sort,
                      groupValue: _defaultSort,
                      onChanged: (value) {
                        setState(() {
                          _defaultSort = value!;
                        });
                        Navigator.pop(context);
                      },
                    )),
          ],
        ),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy Policy'),
        content: const Text('This app collects minimal data for functionality. We do not share your personal information with third parties.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Terms of Service'),
        content: const Text('By using this app, you agree to our terms of service. This app is provided as-is without any warranties.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showContactUs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Us'),
        content: const Text('GitHub: https://github.com/farrakhanwahab\n\nWe\'d love to hear from you!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
} 