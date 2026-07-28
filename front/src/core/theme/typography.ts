import { Dimensions, PixelRatio } from 'react-native';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const scale = SCREEN_WIDTH / 375;

/**
 * Normalizes font size based on screen width for responsive typography across devices.
 */
export function normalizeFont(size: number): number {
  const newSize = size * scale;
  return Math.round(PixelRatio.roundToNearestPixel(newSize));
}

export const Typography = {
  fontSize: {
    xs: normalizeFont(12),
    sm: normalizeFont(14),
    md: normalizeFont(16),
    lg: normalizeFont(18),
    xl: normalizeFont(22),
    xxl: normalizeFont(28),
    title: normalizeFont(34),
  },
  fontWeight: {
    regular: '400' as const,
    medium: '500' as const,
    semibold: '600' as const,
    bold: '700' as const,
  },
  lineHeight: {
    tight: 1.2,
    normal: 1.4,
    relaxed: 1.6,
  },
};
