import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';
import '../widgets/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onThemeToggle;

  const LoginScreen({
    super.key,
    this.onThemeToggle,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _triggerShake() {
    _shakeController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              context.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
            tooltip: 'Cambiar modo',
            onPressed: widget.onThemeToggle,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            _triggerShake();
          } else if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, Routes.hospitals);
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: AnimatedBuilder(
                  animation: _shakeController,
                  builder: (context, child) {
                    final double shakeOffset =
                        sin(_shakeController.value * 6 * pi) * 12 * (1 - _shakeController.value);
                    return Transform.translate(
                      offset: Offset(shakeOffset, 0),
                      child: child,
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header with Logo
                      const LoginHeader()
                          .animate()
                          .fadeIn(duration: 600.ms, curve: Curves.easeOut)
                          .slideY(begin: -0.2, end: 0, duration: 600.ms),

                      const SizedBox(height: 36),

                      // Form Container Card
                      Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: context.isDarkMode
                                  ? Colors.black.withValues(alpha: 0.3)
                                  : theme.colorScheme.primary.withValues(alpha: 0.08),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                          border: Border.all(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.06),
                          ),
                        ),
                        child: LoginForm(
                          onErrorShakeTrigger: _triggerShake,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 700.ms, delay: 200.ms)
                          .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1)),

                      const SizedBox(height: 32),

                      // Social / Auxiliary Login Options
                      const SocialLoginButtons()
                          .animate()
                          .fadeIn(duration: 800.ms, delay: 400.ms),

                      const SizedBox(height: 24),

                      // Footer
                      Center(
                        child: Text(
                          '© ${DateTime.now().year} MovilHospital - Todos los derechos reservados',
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
