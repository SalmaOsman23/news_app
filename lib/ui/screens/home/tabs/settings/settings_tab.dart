import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/my_provider.dart';

class SettingsTab extends StatelessWidget {
  bool arSwitch = false;
  bool darkModeSwitch = false;
  late MyProvider provider;

  SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: provider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          buildSettingsRow("Dark mode", darkModeSwitch, (newValue) {
            if (newValue) {
              darkModeSwitch = newValue;
              provider.setCurrentTheme(ThemeMode.dark);
            } else if (!newValue) {
              darkModeSwitch = newValue;
              provider.setCurrentTheme(ThemeMode.light);
            }
          }),
          Divider(
            thickness: 0.7,
            color: provider.isDarkMode() ? Colors.white : Colors.black,
          ),
          buildSettingsRow("العربية", arSwitch, (newValue) {
            arSwitch = newValue;
          }),
        ],
      ),
    );
  }

  buildSettingsRow(String title, bool switchValue, Function(bool) onChanged) =>
      Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: provider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          Spacer(),
          Switch(value: switchValue, onChanged: onChanged)
        ],
      );
}
