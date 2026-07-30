import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/extensions/context_extensions.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/bloc/auth_state.dart';

class HospitalDrawer extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HospitalDrawer({
    super.key,
    required this.onThemeToggle,
  });

  void _showProfileDialog(BuildContext context, String username, String role) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.account_circle, color: ctx.colorScheme.primary, size: 28),
            const SizedBox(width: 10),
            const Text('Perfil Médico'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Usuario: $username', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Rol: $role', style: const TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 8),
            const Text('Estado: Activo - Personal de Salud', style: TextStyle(color: Colors.green, fontSize: 14)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.headset_mic_rounded, color: ctx.colorScheme.primary, size: 28),
            const SizedBox(width: 10),
            const Text('Soporte Hospitalario'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mesa de Ayuda TI:'),
            SizedBox(height: 6),
            Text('📞 +57 1 8000-HOSPITAL', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text('✉️ soporte@movilhospital.gov.co'),
            SizedBox(height: 12),
            Text('Horario: 24/7 Monitoreo continuo', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          String username = 'Dr. Usuario';
          String role = 'Personal Médico';

          if (authState is AuthSuccess) {
            username = authState.user.username;
            role = authState.user.role;
          }

          return Column(
            children: [
              // User Header
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.local_hospital_rounded,
                    size: 36,
                    color: theme.colorScheme.primary,
                  ),
                ),
                accountName: Text(
                  username.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  'Rol: $role',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 13,
                  ),
                ),
              ),

              // Menu Items
              ListTile(
                leading: Icon(Icons.person_outline_rounded, color: theme.colorScheme.primary),
                title: const Text('Ver perfil', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  _showProfileDialog(context, username, role);
                },
              ),
              ListTile(
                leading: Icon(Icons.support_agent_rounded, color: theme.colorScheme.primary),
                title: const Text('Soporte', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  _showSupportDialog(context);
                },
              ),
              ListTile(
                leading: Icon(
                  context.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  color: theme.colorScheme.primary,
                ),
                title: Text(
                  context.isDarkMode ? 'Cambiar a modo Claro' : 'Cambiar a modo Oscuro',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  onThemeToggle();
                },
              ),

              const Divider(),

              const Spacer(),

              // Logout Button
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    tileColor: theme.colorScheme.error.withValues(alpha: 0.1),
                    leading: Icon(Icons.logout_rounded, color: theme.colorScheme.error),
                    title: Text(
                      'Cerrar sesión',
                      style: TextStyle(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
