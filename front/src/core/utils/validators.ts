/**
 * Utility functions for form input validation
 */
export const validators = {
  isValidUsername: (username: string): boolean => {
    return username.trim().length >= 3;
  },

  isValidEmail: (email: string): boolean => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email.trim());
  },

  isValidPassword: (password: string): boolean => {
    return password.length >= 4;
  },
};
