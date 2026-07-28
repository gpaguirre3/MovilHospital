import React from 'react';
import { View, Text, StyleSheet, useColorScheme } from 'react-native';
import { Colors } from '../../../../core/theme/colors';
import { Typography } from '../../../../core/theme/typography';

export const LoginHeader: React.FC = () => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;

  return (
    <View style={styles.container}>
      <View style={[styles.iconContainer, { backgroundColor: theme.primaryLight }]}>
        <Text style={[styles.iconText, { color: theme.primary }]}>🏥</Text>
      </View>

      <Text style={[styles.title, { color: theme.textPrimary }]}>MovilHospital</Text>
      <Text style={[styles.subtitle, { color: theme.textSecondary }]}>
        Acceso al Sistema Hospitalario
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    marginBottom: 32,
  },
  iconContainer: {
    width: 72,
    height: 72,
    borderRadius: 36,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 16,
    shadowColor: Colors.light.primary,
    shadowOffset: { width: 0, height: 6 },
    shadowOpacity: 0.12,
    shadowRadius: 10,
    elevation: 4,
  },
  iconText: {
    fontSize: 34,
  },
  title: {
    fontSize: Typography.fontSize.xxl,
    fontWeight: Typography.fontWeight.bold,
    marginBottom: 6,
    letterSpacing: -0.5,
  },
  subtitle: {
    fontSize: Typography.fontSize.md,
    fontWeight: Typography.fontWeight.regular,
    textAlign: 'center',
  },
});
