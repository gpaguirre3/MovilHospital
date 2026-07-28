import { useState } from 'react';
import { LoginUseCase } from '../../../../domain/use-cases/auth/LoginUseCase';
import { AuthRepositoryImpl } from '../../../../data/repositories/AuthRepositoryImpl';
import { validators } from '../../../../core/utils/validators';
import { AuthSession } from '../../../../domain/entities/AuthSession';

const loginUseCase = new LoginUseCase(new AuthRepositoryImpl());

export const useLogin = (onLoginSuccess: (session: AuthSession) => void) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [usernameError, setUsernameError] = useState('');
  const [passwordError, setPasswordError] = useState('');
  const [generalError, setGeneralError] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const validateForm = (): boolean => {
    let isValid = true;
    setUsernameError('');
    setPasswordError('');
    setGeneralError('');

    if (!validators.isValidUsername(username)) {
      setUsernameError('El usuario debe tener al menos 3 caracteres.');
      isValid = false;
    }

    if (!validators.isValidPassword(password)) {
      setPasswordError('La contraseña debe tener al menos 4 caracteres.');
      isValid = false;
    }

    return isValid;
  };

  const handleLogin = async () => {
    if (!validateForm()) return;

    setIsLoading(true);
    setGeneralError('');

    try {
      const session = await loginUseCase.execute(username, password);
      onLoginSuccess(session);
    } catch (error: any) {
      setGeneralError(error.message || 'Error al iniciar sesión. Inténtalo de nuevo.');
    } finally {
      setIsLoading(false);
    }
  };

  return {
    username,
    setUsername,
    password,
    setPassword,
    usernameError,
    passwordError,
    generalError,
    isLoading,
    handleLogin,
  };
};
