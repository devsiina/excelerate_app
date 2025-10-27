import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true;
  String selectedLanguage = 'English';

  final List<String> languages = ['English', 'French', 'Spanish', 'Zulu', 'Afrikaans'];

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 25),
                _buildSectionTitle("Account Settings"),
                _buildListTile(Icons.person_outline, "Edit Profile", "Update your personal info", onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfilePage()));
                }),
                _buildListTile(Icons.lock_outline, "Change Password", "Update your login credentials", onTap: () {}),
                _buildListTile(Icons.credit_card_outlined, "Manage Subscription", "View or modify your plan", onTap: () {}),
                const SizedBox(height: 25),
                _buildSectionTitle("App Preferences"),
                _buildSwitchTile(Icons.dark_mode_outlined, "Dark Mode", isDark, (val) {
                  // Persist via provider
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme(val);
                }),
                _buildSwitchTile(Icons.notifications_active_outlined, "Notifications", notificationsEnabled,
                    (val) => setState(() => notificationsEnabled = val)),
                _buildDropdownTile(Icons.language_outlined, "Language", selectedLanguage, languages, (val) {
                  if (val != null) setState(() => selectedLanguage = val);
                }),
                const SizedBox(height: 25),
                _buildSectionTitle("Support & About"),
                _buildListTile(Icons.help_outline, "Help Center", "FAQs and support", onTap: () {}),
                _buildListTile(Icons.privacy_tip_outlined, "Privacy Policy", "Read our terms", onTap: () {}),
                _buildListTile(Icons.info_outline, "About App", "Version 1.0.0", onTap: () {}),
                const SizedBox(height: 35),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Settings",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.close, size: 26, color: Theme.of(context).iconTheme.color),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    final cardColor = Theme.of(context).cardColor;
    final titleColor = Theme.of(context).textTheme.bodyMedium?.color;
    final subtitleColor = Theme.of(context).textTheme.bodySmall?.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: titleColor)),
        subtitle: Text(subtitle, style: TextStyle(color: subtitleColor)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, Function(bool) onChanged) {
    final cardColor = Theme.of(context).cardColor;
    final titleColor = Theme.of(context).textTheme.bodyMedium?.color;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
        child: SwitchListTile(
        secondary: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: titleColor)),
        value: value,
        activeThumbColor: const Color(0xFFFFC857),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownTile(
      IconData icon, String title, String currentValue, List<String> options, ValueChanged<String?> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            icon: const Icon(Icons.arrow_drop_down),
            items: options.map((lang) {
              return DropdownMenuItem<String>(
                value: lang,
                child: Text(lang, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        onPressed: () {
          _showLogoutDialog(context);
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          foregroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(double.infinity, 50),
        ),
        icon: const Icon(Icons.logout),
        label: const Text("Log Out"),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Log Out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () async {
                Navigator.pop(context); // Close dialog
                final prefs = await SharedPreferences.getInstance();
                await Future.wait([
                  prefs.remove('isLoggedIn'),
                  prefs.remove('user_token'),
                  prefs.remove('user_preferences'),
                ]);
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }
}