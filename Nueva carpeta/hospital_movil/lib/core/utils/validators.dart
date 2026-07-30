class Validators {
  static String? validateEmailOrUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa tu usuario o correo';
    }
    if (value.trim().length < 3) {
      return 'El usuario debe tener al menos 3 caracteres';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingresa tu contraseña';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    }
    return null;
  }
}
