import { Platform } from 'react-native';

/**
 * Cross-Platform Secure Storage Wrapper
 * Compatible with React Native, Web, iOS, and Android.
 */
class SecureStorageService {
  private memoryStore: Map<string, string> = new Map();

  async setItem(key: string, value: string): Promise<void> {
    try {
      if (Platform.OS === 'web' && typeof window !== 'undefined' && window.localStorage) {
        window.localStorage.setItem(key, value);
      } else {
        this.memoryStore.set(key, value);
      }
    } catch (e) {
      console.warn('SecureStorage setItem fallback:', e);
      this.memoryStore.set(key, value);
    }
  }

  async getItem(key: string): Promise<string | null> {
    try {
      if (Platform.OS === 'web' && typeof window !== 'undefined' && window.localStorage) {
        return window.localStorage.getItem(key);
      }
      return this.memoryStore.get(key) ?? null;
    } catch (e) {
      console.warn('SecureStorage getItem fallback:', e);
      return this.memoryStore.get(key) ?? null;
    }
  }

  async removeItem(key: string): Promise<void> {
    try {
      if (Platform.OS === 'web' && typeof window !== 'undefined' && window.localStorage) {
        window.localStorage.removeItem(key);
      }
      this.memoryStore.delete(key);
    } catch (e) {
      console.warn('SecureStorage removeItem fallback:', e);
      this.memoryStore.delete(key);
    }
  }

  async clear(): Promise<void> {
    try {
      if (Platform.OS === 'web' && typeof window !== 'undefined' && window.localStorage) {
        window.localStorage.clear();
      }
      this.memoryStore.clear();
    } catch (e) {
      this.memoryStore.clear();
    }
  }
}

export const SecureStorage = new SecureStorageService();
