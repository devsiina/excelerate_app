import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFFFFC857);
  static const secondaryColor = Color(0xFF6C5CE7);
  static const errorColor = Color(0xFFFF6B6B);
  static const successColor = Color(0xFF00B894);
  static const infoColor = Color(0xFF0984E3);
  
  // Text colors
  static const primaryText = Color(0xFF2D3436);
  static const secondaryText = Color(0xFF636E72);
  
  // Background colors
  static const scaffoldLight = Color(0xFFF5F6FA);
  static const scaffoldDark = Color(0xFF2D3436);
  
  // Card colors
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF3D4852);
}

class AppDimens {
  // Margins & Paddings
  static const double marginXS = 4.0;
  static const double marginS = 8.0;
  static const double marginM = 16.0;
  static const double marginL = 24.0;
  static const double marginXL = 32.0;
  
  // Border radius
  static const double radiusS = 8.0;
  static const double radiusM = 14.0;
  static const double radiusL = 28.0;
  
  // Icon sizes
  static const double iconS = 16.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  
  // Font sizes
  static const double textXS = 12.0;
  static const double textS = 14.0;
  static const double textM = 16.0;
  static const double textL = 18.0;
  static const double textXL = 24.0;
  static const double textXXL = 32.0;
}

class AppAnimations {
  static const Duration shortest = Duration(milliseconds: 150);
  static const Duration short = Duration(milliseconds: 250);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration long = Duration(milliseconds: 500);
}

class AppConstants {
  static const String appName = 'Excelerate';
  static const String appVersion = '1.0.0';
  
  // API endpoints
  static const String baseUrl = 'https://api.excelerate.app';
  static const String apiVersion = 'v1';
  
  // Storage keys
  static const String tokenKey = 'user_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'app_theme';
  static const String localeKey = 'app_locale';
  
  // Image paths
  static const String avatarPlaceholder = 'assets/avatar_placeholder.png';
  
  // Error messages
  static const String networkError = 'Please check your internet connection';
  static const String generalError = 'Something went wrong. Please try again';
  static const String sessionExpired = 'Your session has expired. Please log in again';
}