import React from 'react';
import { View, Text, StyleSheet, useColorScheme } from 'react-native';
import { Input } from '../../../components/Input/Input';
import { Button } from '../../../components/Button/Button';
import { Colors } from '../../../../core/theme/colors';
import { Typography } from '../../../../core/theme/typography';

interface LoginFormProps {
  username: string;
  setUsername: (value: string) => void;
  password: string;
  setPassword: (value: string) => void;
  usernameError?: string;
  passwordError?: string;
  generalError?: string;
  isLoading: boolean;
  onSubmit: () => void;
}

export const LoginForm: React.FC<LoginFormProps> = ({
  username,
  setUsername,
  password,
  setPassword,
  usernameError,
  passwordError,
  generalError,
  isLoading,
  onSubmit,
}) => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;

  return (
    <View style={styles.container}>
      {generalError ? (
        <View style={[styles.errorBanner, { backgroundColor: theme.errorLight, borderColor: theme.error }]}>
          <Text style={[styles.errorBannerText, { color: theme.error }]}>{generalError}</Text>
        </View>
      ) : null}

      <Input
        autoCapitalize="none"
        autoCorrect={false}
        error={usernameError}
        label="Usuario / Documento"
        placeholder="Ingresa tu usuario"
        value={username}
        onChangeText={setUsername}
      />

      <Input
        isPassword
        autoCapitalize="none"
        error={passwordError}
        label="Contraseña"
        placeholder="Ingresa tu contraseña"
        value={password}
        onChangeText={setPassword}
      />

      <View style={styles.buttonSpacer} />

      <Button
        loading={isLoading}
        size="lg"
        title="Iniciar Sesión"
        onPress={onSubmit}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    width: '100%',
  },
  errorBanner: {
    padding: 12,
    borderRadius: 12,
    borderWidth: 1,
    marginBottom: 16,
  },
  errorBannerText: {
    fontSize: Typography.fontSize.sm,
    fontWeight: Typography.fontWeight.medium,
    textAlign: 'center',
  },
  buttonSpacer: {
    height: 12,
  },
});
