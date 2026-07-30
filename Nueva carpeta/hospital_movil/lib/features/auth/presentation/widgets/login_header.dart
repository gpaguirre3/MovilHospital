import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Premium Hospital Logo Container
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.local_hospital_rounded,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Seguimiento Hospitalario',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ingresa a tu cuenta para gestionar el monitoreo médico y expedientes',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
