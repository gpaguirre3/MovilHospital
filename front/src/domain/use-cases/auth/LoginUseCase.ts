import { AuthSession } from '../../entities/AuthSession';
import { IAuthRepository } from '../../repositories/IAuthRepository';

export class LoginUseCase {
  constructor(private authRepository: IAuthRepository) {}

  async execute(username: string, password: string): Promise<AuthSession> {
    if (!username || !username.trim()) {
      throw new Error('El usuario es requerido.');
    }
    if (!password) {
      throw new Error('La contraseña es requerida.');
    }
    return await this.authRepository.login(username.trim(), password);
  }
}
