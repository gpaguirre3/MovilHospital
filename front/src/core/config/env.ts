import { Platform } from 'react-native';

/**
 * Global Environment Configuration
 * Handles dynamic host selection for Android, iOS, and Web environments.
 */
const getBaseUrl = (): string => {
  // Configured with PC Wi-Fi IP so APK on physical device connects to backend Java
  const MANUAL_DEV_IP: string | null = 'http://192.168.18.11:8080';

  if (MANUAL_DEV_IP) {
    return MANUAL_DEV_IP;
  }

  if (Platform.OS === 'android') {
    // 10.0.2.2 is the Android emulator's alias to host loopback interface
    return 'http://10.0.2.2:8080';
  }

  if (Platform.OS === 'ios') {
    return 'http://localhost:8080';
  }

  // Fallback for Web or other platforms
  return 'http://localhost:8080';
};

export const ENV = {
  API_BASE_URL: getBaseUrl(),
  TIMEOUT_MS: 15000,
  APP_NAME: 'MovilHospital',
};
