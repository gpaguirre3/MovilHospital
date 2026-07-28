import { AuthSession } from '../../domain/entities/AuthSession';
import { AuthResponseDTO } from '../datasources/remote/AuthApi';

export class UserMapper {
  public static toDomainSession(dto: AuthResponseDTO): AuthSession {
    return {
      token: dto.token,
      message: dto.message,
      user: {
        username: dto.username,
        role: dto.role,
        personId: dto.personId,
      },
    };
  }
}
