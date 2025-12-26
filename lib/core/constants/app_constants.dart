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

  // Backend API Configuration
  // For development: use localhost with 10.0.2.2 for Android emulator
  // For iOS simulator: use localhost
  // For physical device: use your machine's IP address
  static const bool useLocalBackend = true;
  
  // Local development URLs (use 10.0.2.2 for Android emulator to access host machine)
  static const String _localHost = '10.0.2.2'; // Android emulator host
  static const String _localHostIOS = 'localhost'; // iOS simulator
  
  // Backend Service Ports
  static const int tsrHealthPort = 8003;
  static const int spacedRepetitionPort = 8001;
  static const int cognitiveLoadPort = 8002;
  static const int examPrepPort = 8004;  // JEE, NEET, UPSC exam prep
  static const int boardExamPort = 8005; // CBSE, ICSE board exam
  static const int apiGatewayPort = 3001;
  
  // Backend API Base URLs
  static String get tsrHealthBaseUrl => useLocalBackend 
      ? 'http://$_localHost:$tsrHealthPort' 
      : 'https://api.retainlearn.com';
  
  static String get spacedRepetitionBaseUrl => useLocalBackend 
      ? 'http://$_localHost:$spacedRepetitionPort' 
      : 'https://api.retainlearn.com';
  
  static String get cognitiveLoadBaseUrl => useLocalBackend 
      ? 'http://$_localHost:$cognitiveLoadPort' 
      : 'https://api.retainlearn.com';

  static String get examPrepBaseUrl => useLocalBackend 
      ? 'http://$_localHost:$examPrepPort' 
      : 'https://api.retainlearn.com';

  static String get boardExamBaseUrl => useLocalBackend 
      ? 'http://$_localHost:$boardExamPort' 
      : 'https://api.retainlearn.com';

  // API Endpoints
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
