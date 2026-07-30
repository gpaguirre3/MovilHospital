import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection_container.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../activities/domain/entities/activity_entity.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../hospitals/domain/entities/hospital.dart';
import '../../domain/entities/record_entity.dart';

class ActivityHistoryItem {
  final String activityName;
  final String subactivityName;
  final String startTime;
  final String endTime;

  const ActivityHistoryItem({
    required this.activityName,
    required this.subactivityName,
    required this.startTime,
    required this.endTime,
  });
}

class EjecucionActividadScreen extends StatefulWidget {
  final int? processActivityId;
  final ActivityEntity? activity;
  final SubactivityEntity? subactivity;
  final Hospital? hospital;
  final RecordEntity? record;
  final String? startTime;
  final String? startTimeIso;
  final List<ActivityHistoryItem>? history;
  final VoidCallback onThemeToggle;

  const EjecucionActividadScreen({
    super.key,
    this.processActivityId,
    this.activity,
    this.subactivity,
    this.hospital,
    this.record,
    this.startTime,
    this.startTimeIso,
    this.history,
    required this.onThemeToggle,
  });

  @override
  State<EjecucionActividadScreen> createState() => _EjecucionActividadScreenState();
}

class _EjecucionActividadScreenState extends State<EjecucionActividadScreen> {
  bool _isSaving = false;
  late List<ActivityHistoryItem> _historyList;
  late String _currentStartTime;

  List<String> _processEventOptions = ['INCLUIR', 'NO_INCLUIR'];

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    final formattedNow =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    _currentStartTime = widget.startTime ?? formattedNow;

    _historyList = List.from(widget.history ?? []);
    _fetchProcessActivityEvents();
  }

  Future<void> _fetchProcessActivityEvents() async {
    try {
      final dioClient = sl<DioClient>();
      final response = await dioClient.get('/process-activities/events');
      if (response.data is List) {
        final fetched = (response.data as List).map((e) => e.toString()).toList();
        if (fetched.isNotEmpty && mounted) {
          setState(() {
            _processEventOptions = fetched;
          });
        }
      }
    } catch (_) {}
  }

  void _showProcessEventDialog({required bool isCambiarActividad}) {
    String selectedOption = _processEventOptions.first;
    final TextEditingController observationController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = context.theme;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: theme.colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              title: Row(
                children: [
                  Icon(
                    Icons.rule_folder_rounded,
                    color: theme.colorScheme.primary,
                    size: 26,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Tipo de Evento',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._processEventOptions.map((option) {
                      final isSelected = selectedOption == option;
                      return InkWell(
                        onTap: () {
                          setDialogState(() {
                            selectedOption = option;
                          });
                        },
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.onSurface.withValues(alpha: 0.1),
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              // ignore: deprecated_member_use
                              Radio<String>(
                                value: option,
                                // ignore: deprecated_member_use
                                groupValue: selectedOption,
                                activeColor: theme.colorScheme.primary,
                                // ignore: deprecated_member_use
                                onChanged: (val) {
                                  if (val != null) {
                                    setDialogState(() {
                                      selectedOption = val;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  option,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 14),
                    Text(
                      'Observación (Opcional):',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      controller: observationController,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: 'Escribe una observación...',
                        hintStyle: const TextStyle(fontSize: 12.5, color: Colors.grey),
                        filled: true,
                        fillColor: context.isDarkMode
                            ? theme.scaffoldBackgroundColor.withValues(alpha: 0.5)
                            : Colors.grey.shade100,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final userObs = observationController.text.trim();
                          Navigator.pop(context);
                          _processActivityCompletion(
                            selectedOption: selectedOption,
                            customObservation: userObs.isNotEmpty ? userObs : selectedOption,
                            isCambiarActividad: isCambiarActividad,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Confirmar'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _processActivityCompletion({
    required String selectedOption,
    required String customObservation,
    required bool isCambiarActividad,
  }) async {
    setState(() {
      _isSaving = true;
    });

    final authState = context.read<AuthBloc>().state;
    int? personId;
    if (authState is AuthSuccess) {
      personId = authState.user.personId;
    }

    final dioClient = sl<DioClient>();

    final now = DateTime.now();
    final endIso = now.toIso8601String();
    final endTimeStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    final startIso = widget.startTimeIso ?? now.toIso8601String();

    try {
      if (widget.processActivityId != null) {
        // PUT /api/process-activities/{id} to update existing active record in PROCESSACTIVITY table
        await dioClient.put(
          '/process-activities/${widget.processActivityId}',
          data: {
            'processActivityId': widget.processActivityId,
            'personId': personId ?? 1,
            'hospitalId': widget.hospital?.id ?? 1,
            'processActivityDateStart': startIso,
            'processActivityDateEnd': endIso,
            'processActivityEvent': selectedOption,
            'processActivityObservation': customObservation,
          },
        );
      } else {
        // POST /api/process-activities if new
        await dioClient.post(
          '/process-activities',
          data: {
            'personId': personId ?? 1,
            'hospitalId': widget.hospital?.id ?? 1,
            'processActivityDateStart': startIso,
            'processActivityDateEnd': endIso,
            'processActivityEvent': selectedOption,
            'processActivityObservation': customObservation,
          },
        );
      }
    } catch (_) {}

    // Append completed activity to history list
    final finishedItem = ActivityHistoryItem(
      activityName: widget.activity?.name ?? 'Sin Actividad',
      subactivityName: widget.subactivity?.name ?? 'Sin Subactividad',
      startTime: _currentStartTime,
      endTime: endTimeStr,
    );
    _historyList.add(finishedItem);

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      if (isCambiarActividad) {
        // Return to InicioActividadScreen passing updated history list
        Navigator.pop(context, _historyList);
      } else {
        // Complete execution and return to RegistroScreen or SelectedHospitalsScreen safely
        Navigator.of(context).popUntil(
          (route) =>
              route.isFirst ||
              route.settings.name == Routes.registro ||
              route.settings.name == Routes.selectedHospitals,
        );
      }
    }
  }

  Future<bool> _showCancelConfirmationDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final theme = context.theme;

        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          actionsPadding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.amber.shade800,
                size: 28,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '¿Deseas cancelar la actividad?',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 16.5,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            'Si cancelas, regresarás a la pantalla anterior para poder seleccionar una nueva actividad.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.4,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: const StadiumBorder(),
                    ),
                    child: const Text('Aceptar'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final activityTitle = widget.activity?.name ?? 'PROCESO DE INGRESO PDV / SUPERVISORES';
    final subactivityTitle = widget.subactivity?.name ?? 'CHECK IN Y APERTURA DE SGI.';

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showCancelConfirmationDialog();
        if (shouldPop && context.mounted) {
          Navigator.pop(context, _historyList);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Ejecución Actividad'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () async {
              final shouldPop = await _showCancelConfirmationDialog();
              if (shouldPop && context.mounted) {
                Navigator.pop(context, _historyList);
              }
            },
          ),
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
      body: _isSaving
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLoader(size: 40),
                  SizedBox(height: 16),
                  Text('Procesando actividad en el servidor...'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Header Title
                        Text(
                          'Histórico Actividades/Ejecución Actual',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // History Cards List (Past finished activities)
                        ..._historyList.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Actividad: ${item.activityName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13.5,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Sub actividad: ${item.subactivityName}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Fecha y Hora Inicio: ${item.startTime}',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Fecha y Hora Fin: ${item.endTime}',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                        const SizedBox(height: 12),

                        // Active Execution Card Header
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Actividad Actual:',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Active Execution Glassmorphic Card
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(alpha: 0.25),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Actividad: $activityTitle',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Sub actividad: $subactivityTitle',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5,
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.85),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Fecha y Hora Inicio: $_currentStartTime',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Fecha y Hora Fin: ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'En Ejecución',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0),
                      ],
                    ),
                  ),
                ),

                // Bottom Action Buttons: "Cambiar Actividad" and "Fin Ejecución"
                SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(28)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, -4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Button 1: "Cambiar Actividad"
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: () => _showProcessEventDialog(isCambiarActividad: true),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: theme.colorScheme.primary,
                                width: 1.8,
                              ),
                              shape: const StadiumBorder(),
                            ),
                            icon: Icon(
                              Icons.swap_horiz_rounded,
                              color: theme.colorScheme.primary,
                            ),
                            label: Text(
                              'Cambiar Actividad',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Button 2: "Fin Ejecución"
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: () => _showProcessEventDialog(isCambiarActividad: false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 3,
                              shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
                              shape: const StadiumBorder(),
                            ),
                            icon: const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 22,
                            ),
                            label: const Text(
                              'Fin Ejecución',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    ),
    );
  }
}
