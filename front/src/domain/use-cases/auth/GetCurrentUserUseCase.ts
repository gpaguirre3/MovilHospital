import { AuthSession } from '../../entities/AuthSession';
import { IAuthRepository } from '../../repositories/IAuthRepository';

export class GetCurrentUserUseCase {
  constructor(private authRepository: IAuthRepository) {}

  async execute(): Promise<AuthSession | null> {
    return await this.authRepository.getCurrentSession();
  }
}
