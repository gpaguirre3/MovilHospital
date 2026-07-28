import React from 'react';
import { View, ActivityIndicator, Text, StyleSheet, useColorScheme } from 'react-native';
import { Colors } from '../../../core/theme/colors';
import { Typography } from '../../../core/theme/typography';

interface LoaderProps {
  message?: string;
  fullScreen?: boolean;
}

export const Loader: React.FC<LoaderProps> = ({ message, fullScreen = false }) => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;

  const content = (
    <View style={styles.contentContainer}>
      <ActivityIndicator color={theme.primary} size="large" />
      {message ? (
        <Text style={[styles.message, { color: theme.textSecondary }]}>{message}</Text>
      ) : null}
    </View>
  );

  if (fullScreen) {
    return (
      <View style={[styles.fullScreen, { backgroundColor: theme.background }]}>
        {content}
      </View>
    );
  }

  return content;
};

const styles = StyleSheet.create({
  fullScreen: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  contentContainer: {
    padding: 20,
    justifyContent: 'center',
    alignItems: 'center',
    gap: 12,
  },
  message: {
    fontSize: Typography.fontSize.sm,
    fontWeight: Typography.fontWeight.medium,
  },
});
