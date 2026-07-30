import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_input.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback? onErrorShakeTrigger;

  const LoginForm({
    super.key,
    this.onErrorShakeTrigger,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      context.read<AuthBloc>().add(
            LoginRequested(
              username: _usernameController.text.trim(),
              password: _passwordController.text,
            ),
          );
    } else {
      widget.onErrorShakeTrigger?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Username / Email Input
          AppInput(
            controller: _usernameController,
            label: 'Usuario o Correo Médico',
            hint: 'ej. dr.perez@hospital.com',
            prefixIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: Validators.validateEmailOrUsername,
          ),
          const SizedBox(height: 20),

          // Password Input
          AppInput(
            controller: _passwordController,
            label: 'Contraseña',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _submitForm(),
            validator: Validators.validatePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 12),

          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Submit Button
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              final isLoading = state is AuthLoading;

              return AppButton(
                text: 'Iniciar sesión',
                isLoading: isLoading,
                onPressed: _submitForm,
              );
            },
          ),
        ],
      ),
    );
  }
}
