/**
 * MovilHospital Design System - Color Palette
 * Curated HSL-tailored colors for modern medical UI aesthetic.
 */
export const Colors = {
  light: {
    primary: '#0284C7',        // Vibrant Clinical Blue
    primaryDark: '#0369A1',
    primaryLight: '#E0F2FE',
    secondary: '#0D9488',      // Medical Teal Accent
    secondaryLight: '#CCFBF1',
    background: '#F8FAFC',     // Clean slate background
    surface: '#FFFFFF',        // Pure white card surface
    surfaceBorder: '#E2E8F0',  // Subtle border
    textPrimary: '#0F172A',    // Deep slate text
    textSecondary: '#64748B',  // Muted gray text
    textPlaceholder: '#94A3B8',
    error: '#EF4444',          // Alert Red
    errorLight: '#FEE2E2',
    success: '#10B981',        // Emerald Green
    successLight: '#D1FAE5',
    warning: '#F59E0B',        // Warm Amber
    warningLight: '#FEF3C7',
    glassBackground: 'rgba(255, 255, 255, 0.85)',
    glassBorder: 'rgba(226, 232, 240, 0.8)',
    shadow: 'rgba(15, 23, 42, 0.08)',
  },
  dark: {
    primary: '#38BDF8',        // Bright Sky Blue
    primaryDark: '#0284C7',
    primaryLight: '#075985',
    secondary: '#2DD4BF',      // Cyan-Teal
    secondaryLight: '#115E59',
    background: '#0F172A',     // Dark slate background
    surface: '#1E293B',        // Dark slate surface
    surfaceBorder: '#334155',
    textPrimary: '#F8FAFC',
    textSecondary: '#94A3B8',
    textPlaceholder: '#64748B',
    error: '#F87171',
    errorLight: '#451A1A',
    success: '#34D399',
    successLight: '#064E3B',
    warning: '#FBBF24',
    warningLight: '#451A03',
    glassBackground: 'rgba(30, 41, 59, 0.85)',
    glassBorder: 'rgba(51, 65, 85, 0.8)',
    shadow: 'rgba(0, 0, 0, 0.4)',
  },
};

export type ThemeColors = typeof Colors.light;
