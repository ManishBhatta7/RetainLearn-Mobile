/// Application-wide constants
/// 
/// Contains all static configuration values. Environment-specific values
/// should ideally be loaded from environment variables in production.
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'RetainLearn';
  static const String appVersion = '1.0.0';

  // Supabase Configuration
  // TODO: Move to environment variables for production
  static const String supabaseUrl = 'https://gwarmogcmeehajnevbmi.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd3YXJtb2djbWVlaGFqbmV2Ym1pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyOTc1MjAsImV4cCI6MjA2MDg3MzUyMH0.EiTIeIZMrDjMIufMUEuDr74ydPFHtRAIveTvAkBxTds';

  // API Endpoints (for future custom backend)
  static const String customApiBaseUrl = 'https://api.retainlearn.com/v1';

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themePreferenceKey = 'theme_preference';
  static const String languagePreferenceKey = 'language_preference';

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String cacheBox = 'cache_box';
  static const String settingsBox = 'settings_box';

  // Timeouts
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration cacheExpiry = Duration(hours: 24);

  // Pagination
  static const int defaultPageSize = 20;
}
