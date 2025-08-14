import 'dart:io' show Platform;

class ApiConfig {
  // Adjust these as needed for your environment
  static const String _desktopLocal = 'http://localhost:8080';
  static const String _androidEmulator = 'http://10.0.2.2:8080';
  static const String _iosSimulator = 'http://localhost:8080';

  static String get baseUrl {
    if (Platform.isAndroid) return _androidEmulator;
    if (Platform.isIOS) return _iosSimulator;
    return _desktopLocal;
  }
}

