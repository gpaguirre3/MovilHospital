import React from 'react';
import { LoginScreen } from '../../presentation/screens/Auth/LoginScreen';
import { AuthSession } from '../../domain/entities/AuthSession';

interface AuthNavigatorProps {
  onLoginSuccess: (session: AuthSession) => void;
}

export const AuthNavigator: React.FC<AuthNavigatorProps> = ({ onLoginSuccess }) => {
  return <LoginScreen onLoginSuccess={onLoginSuccess} />;
};
