import React from 'react';
import {
  TouchableOpacity,
  Text,
  ActivityIndicator,
  StyleSheet,
  TouchableOpacityProps,
  useColorScheme,
  Animated,
} from 'react-native';
import { Colors } from '../../../core/theme/colors';
import { Typography } from '../../../core/theme/typography';

interface ButtonProps extends TouchableOpacityProps {
  title: string;
  loading?: boolean;
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'sm' | 'md' | 'lg';
}

export const Button: React.FC<ButtonProps> = ({
  title,
  loading = false,
  variant = 'primary',
  size = 'md',
  disabled,
  style,
  onPress,
  ...props
}) => {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? Colors.dark : Colors.light;

  const scaleValue = React.useRef(new Animated.Value(1)).current;

  const handlePressIn = () => {
    Animated.spring(scaleValue, {
      toValue: 0.97,
      useNativeDriver: true,
    }).start();
  };

  const handlePressOut = () => {
    Animated.spring(scaleValue, {
      toValue: 1,
      friction: 4,
      useNativeDriver: true,
    }).start();
  };

  const getBackgroundColor = () => {
    if (disabled || loading) return theme.primaryLight;
    if (variant === 'secondary') return theme.secondary;
    if (variant === 'outline') return 'transparent';
    return theme.primary;
  };

  const getTextColor = () => {
    if (variant === 'outline') return theme.primary;
    return '#FFFFFF';
  };

  return (
    <Animated.View style={{ transform: [{ scale: scaleValue }], width: '100%' }}>
      <TouchableOpacity
        activeOpacity={0.8}
        disabled={disabled || loading}
        onPressIn={handlePressIn}
        onPressOut={handlePressOut}
        onPress={onPress}
        style={[
          styles.baseButton,
          styles[size],
          {
            backgroundColor: getBackgroundColor(),
            borderColor: variant === 'outline' ? theme.primary : 'transparent',
            borderWidth: variant === 'outline' ? 1.5 : 0,
          },
          style,
        ]}
        {...props}
      >
        {loading ? (
          <ActivityIndicator color={getTextColor()} size="small" />
        ) : (
          <Text style={[styles.text, styles[`${size}Text`], { color: getTextColor() }]}>
            {title}
          </Text>
        )}
      </TouchableOpacity>
    </Animated.View>
  );
};

const styles = StyleSheet.create({
  baseButton: {
    borderRadius: 14,
    justifyContent: 'center',
    alignItems: 'center',
    shadowColor: Colors.light.primary,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 3,
  },
  sm: {
    paddingVertical: 10,
    paddingHorizontal: 16,
  },
  md: {
    paddingVertical: 14,
    paddingHorizontal: 20,
  },
  lg: {
    paddingVertical: 18,
    paddingHorizontal: 24,
  },
  text: {
    fontWeight: Typography.fontWeight.semibold,
    textAlign: 'center',
  },
  smText: {
    fontSize: Typography.fontSize.sm,
  },
  mdText: {
    fontSize: Typography.fontSize.md,
  },
  lgText: {
    fontSize: Typography.fontSize.lg,
  },
});
