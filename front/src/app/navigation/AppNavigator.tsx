import React, { useEffect, useState } from 'react';
import { AuthNavigator } from './AuthNavigator';
import { HomeScreen } from '../../presentation/screens/Home/HomeScreen';
import { Loader } from '../../presentation/components/Loader/Loader';
import { AuthSession } from '../../domain/entities/AuthSession';
import { User } from '../../domain/entities/User';
import { GetCurrentUserUseCase } from '../../domain/use-cases/auth/GetCurrentUserUseCase';
import { LogoutUseCase } from '../../domain/use-cases/auth/LogoutUseCase';
import { AuthRepositoryImpl } from '../../data/repositories/AuthRepositoryImpl';

const authRepo = new AuthRepositoryImpl();
const getCurrentUserUseCase = new GetCurrentUserUseCase(authRepo);
const logoutUseCase = new LogoutUseCase(authRepo);

export const AppNavigator: React.FC = () => {
  const [session, setSession] = useState<AuthSession | null>(null);
  const [isInitializing, setIsInitializing] = useState(true);

  useEffect(() => {
    const checkActiveSession = async () => {
      try {
        const activeSession = await getCurrentUserUseCase.execute();
        setSession(activeSession);
      } catch (e) {
        console.warn('Error checking session:', e);
      } finally {
        setIsInitializing(false);
      }
    };
    checkActiveSession();
  }, []);

  const handleLoginSuccess = (newSession: AuthSession) => {
    setSession(newSession);
  };

  const handleLogout = async () => {
    try {
      await logoutUseCase.execute();
    } catch (e) {
      console.warn('Error during logout:', e);
    } finally {
      setSession(null);
    }
  };

  if (isInitializing) {
    return <Loader fullScreen message="Cargando MovilHospital..." />;
  }

  if (!session || !session.token) {
    return <AuthNavigator onLoginSuccess={handleLoginSuccess} />;
  }

  return <HomeScreen user={session.user} onLogout={handleLogout} />;
};
