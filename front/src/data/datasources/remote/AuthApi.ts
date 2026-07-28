import { httpClient } from '../../../core/network/httpClient';

export interface AuthResponseDTO {
  token: string;
  username: string;
  role: string;
  personId?: number;
  message?: string;
}

export interface LoginRequestDTO {
  username: string;
  password: string;
}

export class AuthApi {
  public async login(credentials: LoginRequestDTO): Promise<AuthResponseDTO> {
    return await httpClient.post<AuthResponseDTO>('/api/auth/login', credentials);
  }
}
