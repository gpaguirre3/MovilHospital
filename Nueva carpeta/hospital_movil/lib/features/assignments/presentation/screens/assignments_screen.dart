import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../hospitals/presentation/bloc/hospitals_bloc.dart';
import '../../../hospitals/presentation/bloc/hospitals_event.dart';
import '../../../hospitals/presentation/bloc/hospitals_state.dart';
import '../bloc/assignments_bloc.dart';
import '../bloc/assignments_event.dart';
import '../bloc/assignments_state.dart';
import '../widgets/assignment_list_tile.dart';

class AssignmentsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const AssignmentsScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentsBloc>().add(FetchAssignmentsRequested());
  }

  void _onSelectAssignment(int assignmentId) {
    final authState = context.read<AuthBloc>().state;
    int? personId;
    if (authState is AuthSuccess) {
      personId = authState.user.personId;
    }

    // Trigger hospital update in Java backend linking assignmentsId and personId
    context.read<HospitalsBloc>().add(
          AssignHospitalsRequested(
            assignmentsId: assignmentId,
            personId: personId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return MultiBlocListener(
      listeners: [
        BlocListener<HospitalsBloc, HospitalsState>(
          listener: (context, hospitalsState) {
            if (hospitalsState.isAssignmentSuccess) {
              Navigator.pushReplacementNamed(context, Routes.selectedHospitals);
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Asignaciones'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                context.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              ),
              onPressed: widget.onThemeToggle,
            ),
            const SizedBox(width: 4),
          ],
        ),
        body: BlocBuilder<HospitalsBloc, HospitalsState>(
          builder: (context, hospitalsState) {
            if (hospitalsState.isAssigning) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLoader(size: 40),
                    SizedBox(height: 16),
                    Text(
                      'Guardando asignación en el servidor...',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ],
                ),
              );
            }

            return BlocBuilder<AssignmentsBloc, AssignmentsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppLoader(size: 36),
                        SizedBox(height: 16),
                        Text(
                          'Cargando asignaciones del servidor...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                if (state.errorMessage != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<AssignmentsBloc>()
                                  .add(FetchAssignmentsRequested());
                            },
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    const SizedBox(height: 24),

                    // Title Section Header: Only "ASIGNACIONES"
                    Center(
                      child: Text(
                        'ASIGNACIONES',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // List View of Assignments (Image 2 style)
                    Expanded(
                      child: state.assignments.isEmpty
                          ? Center(
                              child: Text(
                                'No hay asignaciones disponibles',
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.only(top: 8, bottom: 24),
                              physics: const BouncingScrollPhysics(),
                              itemCount: state.assignments.length,
                              itemBuilder: (context, index) {
                                final assignment = state.assignments[index];
                                return AssignmentListTile(
                                  assignment: assignment,
                                  onTap: () {
                                    _onSelectAssignment(assignment.id);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
