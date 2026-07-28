import { User } from './User';

export interface AuthSession {
  token: string;
  user: User;
  message?: string;
}
