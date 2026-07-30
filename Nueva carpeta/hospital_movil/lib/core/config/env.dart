class Env {
  static const String appName = 'MovilHospital';
  // Use your computer's local network IP for physical mobile devices and emulators
  static const String apiBaseUrl = 'http://192.168.18.11:8080/api';
  static const String apiBaseUrlWeb = 'http://localhost:8080/api';

  static const int connectTimeout = 15000; // ms
  static const int receiveTimeout = 15000; // ms
}
