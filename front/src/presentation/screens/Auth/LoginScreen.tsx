import React from 'react';
import {
  View,
  StyleSheet,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  useColorScheme,
  useWindowDimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LoginHeader } from './components/LoginHeader';
import { LoginForm } from './components/LoginForm';
import { useLogin } from './hooks/useLogin';
import { Colors } from '../../../core/theme/colors';
import { AuthSession } from '../../../domain/entities/AuthSession';

interface LoginScreenProps {
  onLoginSuccess: (session: AuthSession) => void;
}

export const LoginScreen: React.FC<LoginScreenProps> = ({ onLoginSuccess }) => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;
  const { width } = useWindowDimensions();

  const loginState = useLogin(onLoginSuccess);

  // Maximum width for tablet/desktop views
  const isLargeScreen = width > 600;
  const containerMaxWidth = isLargeScreen ? 460 : '100%';

  return (
    <SafeAreaView style={[styles.safeArea, { backgroundColor: theme.background }]}>
      <KeyboardAvoidingView
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        style={styles.keyboardView}
      >
        <ScrollView
          contentContainerStyle={[
            styles.scrollContent,
            isLargeScreen && styles.scrollContentLarge,
          ]}
          keyboardShouldPersistTaps="handled"
          showsVerticalScrollIndicator={false}
        >
          <View
            style={[
              styles.card,
              {
                backgroundColor: theme.surface,
                borderColor: theme.surfaceBorder,
                maxWidth: containerMaxWidth,
              },
            ]}
          >
            <LoginHeader />
            <LoginForm
              generalError={loginState.generalError}
              isLoading={loginState.isLoading}
              password={loginState.password}
              passwordError={loginState.passwordError}
              setPassword={loginState.setPassword}
              setUsername={loginState.setUsername}
              username={loginState.username}
              usernameError={loginState.usernameError}
              onSubmit={loginState.handleLogin}
            />
          </View>
        </ScrollView>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  keyboardView: {
    flex: 1,
  },
  scrollContent: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: 20,
  },
  scrollContentLarge: {
    alignItems: 'center',
  },
  card: {
    width: '100%',
    borderRadius: 24,
    padding: 28,
    borderWidth: 1,
    shadowColor: Colors.light.shadow,
    shadowOffset: { width: 0, height: 10 },
    shadowOpacity: 0.1,
    shadowRadius: 20,
    elevation: 5,
  },
});
