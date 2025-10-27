import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  static const _nameKey = 'userName';
  static const _titleKey = 'userTitle';
  static const _emailKey = 'userEmail';
  static const _profilePicKey = 'userProfilePic';

  String _name = 'Moshe Yagami';
  String _title = 'TempleOS Evangelist';
  String _email = 'moshe.yagami@example.com';
  String? _profilePicPath;

  String get name => _name;
  String get title => _title;
  String get email => _email;
  String? get profilePicPath => _profilePicPath;

  UserProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString(_nameKey) ?? _name;
    _title = prefs.getString(_titleKey) ?? _title;
    _email = prefs.getString(_emailKey) ?? _email;
    _profilePicPath = prefs.getString(_profilePicKey);
    notifyListeners();
  }

  Future<void> updateProfile({
    required String name,
    required String title,
    required String email,
    String? profilePicPath,
  }) async {
    _name = name;
    _title = title;
    _email = email;
    if (profilePicPath != null) {
      _profilePicPath = profilePicPath;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_nameKey, name);
    await prefs.setString(_titleKey, title);
    await prefs.setString(_emailKey, email);
    if (profilePicPath != null) {
      await prefs.setString(_profilePicKey, profilePicPath);
    }
  }
}