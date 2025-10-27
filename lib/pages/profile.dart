import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings_page.dart';
import 'edit_profile.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildInfoSection(),
                const SizedBox(height: 20),
                _buildSettingsSection(),
                const SizedBox(height: 30),
                _buildActionButtons(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C5CE7), Color(0xFFFFC857)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        Column(
          children: [
            Stack(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Future: open file picker / camera
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Edit profile picture coming soon')),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFC857),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.edit, size: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Consumer<UserProvider>(
              builder: (context, userProvider, _) => Column(
                children: [
                  Text(
                    userProvider.name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    userProvider.title,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String subtitle) {
  final cardColor = Theme.of(context).cardColor;
  final textColor = Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
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
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
        subtitle: Text(subtitle, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Profile Info",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 10),
        Consumer<UserProvider>(
          builder: (context, userProvider, _) => 
            _buildInfoCard(Icons.email_outlined, "Email", userProvider.email),
        ),
        _buildInfoCard(Icons.location_on_outlined, "Location", "Johannesburg, South Africa"),
        _buildInfoCard(Icons.calendar_today_outlined, "Joined", "January 2023"),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SettingsPage()),
                  ),
                  child: const Text("More Settings",
                      style: TextStyle(color: Color(0xFF6C5CE7))),
                ),
          ],
        ),
        const SizedBox(height: 10),
        _buildSwitchTile(
          Icons.dark_mode_outlined,
          "Dark Mode",
          Provider.of<ThemeProvider>(context).isDarkMode,
          (value) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
          },
        ),
        _buildSwitchTile(
          Icons.notifications_active_outlined,
          "Push Notifications",
          notificationsEnabled,
          (value) => setState(() => notificationsEnabled = value),
        ),
      ],
    );
  }

  Widget _buildSwitchTile(
      IconData icon, String title, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: const Color(0xFF6C5CE7)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        value: value,
        activeThumbColor: const Color(0xFFFFC857),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditProfilePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC857),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: const Icon(Icons.edit_outlined),
          label: const Text("Edit Profile"),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () async {

            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('isLoggedIn');
            if (!mounted) return;
    
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.red),
            foregroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          icon: const Icon(Icons.logout),
          label: const Text("Log Out"),
        ),
      ],
    );
  }
}
