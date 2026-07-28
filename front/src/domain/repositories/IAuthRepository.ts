import { AuthSession } from '../entities/AuthSession';

export interface IAuthRepository {
  login(username: string, password: string): Promise<AuthSession>;
  logout(): Promise<void>;
  getCurrentSession(): Promise<AuthSession | null>;
}
