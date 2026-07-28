import { AuthSession } from '../../domain/entities/AuthSession';
import { IAuthRepository } from '../../domain/repositories/IAuthRepository';
import { AuthApi } from '../datasources/remote/AuthApi';
import { AuthLocalDataSource } from '../datasources/local/AuthLocalDataSource';
import { UserMapper } from '../mappers/UserMapper';

export class AuthRepositoryImpl implements IAuthRepository {
  constructor(
    private remoteDataSource: AuthApi = new AuthApi(),
    private localDataSource: AuthLocalDataSource = new AuthLocalDataSource()
  ) {}

  async login(username: string, password: string): Promise<AuthSession> {
    const dto = await this.remoteDataSource.login({ username, password });
    const session = UserMapper.toDomainSession(dto);
    await this.localDataSource.saveSession(session);
    return session;
  }

  async logout(): Promise<void> {
    await this.localDataSource.clearSession();
  }

  async getCurrentSession(): Promise<AuthSession | null> {
    return await this.localDataSource.getSession();
  }
}
