import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'o continuar con',
                style: TextStyle(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(
                  Icons.fingerprint,
                  color: theme.colorScheme.primary,
                ),
                label: Text(
                  'Biometría',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(
                  Icons.support_agent_rounded,
                  color: theme.colorScheme.primary,
                ),
                label: Text(
                  'Soporte',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
