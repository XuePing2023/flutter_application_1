import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTab),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(l10n.changeTheme),
            trailing: Switch(
              value: appProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                appProvider.toggleTheme(value);
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l10n.changeLanguage),
            trailing: DropdownButton<Locale>(
              value: appProvider.locale,
              onChanged: (Locale? newValue) {
                if (newValue != null) {
                  appProvider.changeLocale(newValue);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: Locale('zh'),
                  child: Text('中文'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
