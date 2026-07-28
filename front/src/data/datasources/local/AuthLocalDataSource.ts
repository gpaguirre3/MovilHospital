import { SecureStorage } from '../../../core/storage/SecureStorage';
import { AuthSession } from '../../../domain/entities/AuthSession';

export class AuthLocalDataSource {
  private static readonly TOKEN_KEY = 'AUTH_TOKEN';
  private static readonly SESSION_KEY = 'AUTH_SESSION';

  public async saveSession(session: AuthSession): Promise<void> {
    await SecureStorage.setItem(AuthLocalDataSource.TOKEN_KEY, session.token);
    await SecureStorage.setItem(AuthLocalDataSource.SESSION_KEY, JSON.stringify(session));
  }

  public async getSession(): Promise<AuthSession | null> {
    const rawSession = await SecureStorage.getItem(AuthLocalDataSource.SESSION_KEY);
    if (!rawSession) return null;
    try {
      return JSON.parse(rawSession) as AuthSession;
    } catch {
      return null;
    }
  }

  public async clearSession(): Promise<void> {
    await SecureStorage.removeItem(AuthLocalDataSource.TOKEN_KEY);
    await SecureStorage.removeItem(AuthLocalDataSource.SESSION_KEY);
  }
}
