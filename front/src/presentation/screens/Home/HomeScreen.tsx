import React from 'react';
import { View, Text, StyleSheet, useColorScheme } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Button } from '../../components/Button/Button';
import { Colors } from '../../../core/theme/colors';
import { Typography } from '../../../core/theme/typography';
import { User } from '../../../domain/entities/User';

interface HomeScreenProps {
  user: User | null;
  onLogout: () => void;
}

export const HomeScreen: React.FC<HomeScreenProps> = ({ user, onLogout }) => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;

  return (
    <SafeAreaView style={[styles.safeArea, { backgroundColor: theme.background }]}>
      <View style={styles.container}>
        <View
          style={[
            styles.card,
            { backgroundColor: theme.surface, borderColor: theme.surfaceBorder },
          ]}
        >
          <View style={[styles.avatar, { backgroundColor: theme.primaryLight }]}>
            <Text style={[styles.avatarText, { color: theme.primary }]}>
              {user?.username?.charAt(0).toUpperCase() || 'U'}
            </Text>
          </View>

          <Text style={[styles.welcomeTitle, { color: theme.textPrimary }]}>
            ¡Bienvenido(a)!
          </Text>

          <Text style={[styles.usernameText, { color: theme.primary }]}>
            @{user?.username || 'usuario'}
          </Text>

          <View style={[styles.badge, { backgroundColor: theme.secondaryLight }]}>
            <Text style={[styles.badgeText, { color: theme.secondary }]}>
              Rol: {user?.role || 'USUARIO'}
            </Text>
          </View>

          {user?.personId ? (
            <Text style={[styles.personIdText, { color: theme.textSecondary }]}>
              ID de Persona: {user.personId}
            </Text>
          ) : null}
        </View>

        <View style={styles.actionContainer}>
          <Button variant="outline" title="Cerrar Sesión" onPress={onLogout} />
        </View>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  container: {
    flex: 1,
    padding: 24,
    justifyContent: 'center',
    alignItems: 'center',
  },
  card: {
    width: '100%',
    maxWidth: 440,
    borderRadius: 24,
    padding: 32,
    alignItems: 'center',
    borderWidth: 1,
    shadowColor: Colors.light.shadow,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.1,
    shadowRadius: 16,
    elevation: 4,
    marginBottom: 24,
  },
  avatar: {
    width: 80,
    height: 80,
    borderRadius: 40,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
  },
  avatarText: {
    fontSize: 36,
    fontWeight: Typography.fontWeight.bold,
  },
  welcomeTitle: {
    fontSize: Typography.fontSize.xl,
    fontWeight: Typography.fontWeight.bold,
    marginBottom: 4,
  },
  usernameText: {
    fontSize: Typography.fontSize.lg,
    fontWeight: Typography.fontWeight.semibold,
    marginBottom: 16,
  },
  badge: {
    paddingHorizontal: 16,
    paddingVertical: 6,
    borderRadius: 20,
    marginBottom: 12,
  },
  badgeText: {
    fontSize: Typography.fontSize.sm,
    fontWeight: Typography.fontWeight.semibold,
  },
  personIdText: {
    fontSize: Typography.fontSize.xs,
  },
  actionContainer: {
    width: '100%',
    maxWidth: 440,
  },
});
