import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/injection_container.dart';
import '../../../../app/router/routes.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../activities/domain/entities/activity_entity.dart';
import '../../../activities/domain/usecases/get_activities_usecase.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../hospitals/domain/entities/hospital.dart';
import '../../domain/entities/record_entity.dart';
import 'ejecucion_actividad_screen.dart';

class InicioActividadScreen extends StatefulWidget {
  final RecordEntity? record;
  final Hospital? hospital;
  final VoidCallback onThemeToggle;

  const InicioActividadScreen({
    super.key,
    this.record,
    this.hospital,
    required this.onThemeToggle,
  });

  @override
  State<InicioActividadScreen> createState() => _InicioActividadScreenState();
}

class _InicioActividadScreenState extends State<InicioActividadScreen> {
  late String _lastVisitDate;
  bool _isLoading = true;
  bool _isSaving = false;

  List<ActivityEntity> _activities = [];
  List<SubactivityEntity> _subactivities = [];
  List<ActivityHistoryItem> _sessionHistory = [];

  ActivityEntity? _selectedActivity;
  SubactivityEntity? _selectedSubactivity;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final year = now.year;
    _lastVisitDate = '$day/$month/$year';

    _fetchActivitiesAndSubactivities();
  }

  Future<void> _fetchActivitiesAndSubactivities() async {
    setState(() {
      _isLoading = true;
    });

    final getActivitiesUseCase = sl<GetActivitiesUseCase>();

    final resAct = await getActivitiesUseCase(
      GetActivitiesParams(recordId: widget.record?.id),
    );

    if (resAct is Success<List<ActivityEntity>>) {
      _activities = resAct.data;
    }

    if (_activities.isNotEmpty) {
      _selectedActivity = _activities.first;
      await _fetchSubactivitiesForSelectedActivity(_selectedActivity!.id);
    } else {
      _selectedActivity = null;
      _subactivities = [];
      _selectedSubactivity = null;
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchSubactivitiesForSelectedActivity(int activityId) async {
    final getSubactivitiesUseCase = sl<GetSubactivitiesUseCase>();
    final resSub = await getSubactivitiesUseCase(
      GetSubactivitiesParams(activityId: activityId),
    );

    if (resSub is Success<List<SubactivityEntity>>) {
      _subactivities = resSub.data;
    } else {
      _subactivities = [];
    }

    if (_subactivities.isNotEmpty) {
      _selectedSubactivity = _subactivities.first;
    } else {
      _selectedSubactivity = null;
    }
  }

  Future<void> _handleActivityToggle() async {
    if (_selectedActivity == null || _selectedSubactivity == null) {
      context.showSnackBar('Debes seleccionar una actividad y subactividad', isError: true);
      return;
    }

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
    final startTimeStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

    int? createdProcessActivityId;

    try {
      // 1. Save in PROCESSACTIVITY table
      final processResponse = await dioClient.post(
        '/process-activities',
        data: {
          'personId': personId ?? 1,
          'hospitalId': widget.hospital?.id ?? 1,
          'processActivityDateStart': now.toIso8601String(),
          'processActivityObservation':
              '${_selectedActivity?.name} - ${_selectedSubactivity?.name}',
        },
      );

      if (processResponse.data != null && processResponse.data['processActivityId'] != null) {
        createdProcessActivityId = processResponse.data['processActivityId'] as int;
      }

      // 2. Save in TIMEACTIVITY table (PROCESSACTIVITYID, SUBACTIVITYID, timeactivityid)
      if (createdProcessActivityId != null && _selectedSubactivity != null) {
        await dioClient.post(
          '/time-activities',
          data: {
            'processActivityId': createdProcessActivityId,
            'subactivityId': _selectedSubactivity!.id,
            'timeActivityId': 1,
          },
        );
      }
    } catch (_) {}

    if (mounted) {
      setState(() {
        _isSaving = false;
      });

      final result = await Navigator.pushNamed(
        context,
        Routes.ejecucionActividad,
        arguments: {
          'processActivityId': createdProcessActivityId,
          'activity': _selectedActivity,
          'subactivity': _selectedSubactivity,
          'hospital': widget.hospital,
          'record': widget.record,
          'startTime': startTimeStr,
          'startTimeIso': now.toIso8601String(),
          'history': _sessionHistory,
        },
      );

      if (result is List<ActivityHistoryItem>) {
        setState(() {
          _sessionHistory = result;
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final titleText = widget.record?.name ?? 'REGISTRO DE ACTIVIDAD';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(titleText.toLowerCase()),
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
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLoader(size: 38),
                  SizedBox(height: 16),
                  Text('Cargando actividades del servidor...'),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Subtitle Badge: "Última fecha Ingreso módulo: 22/07/2026"
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Última fecha Ingreso módulo: $_lastVisitDate',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0),

                  const SizedBox(height: 28),

                  // Main Form Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label 1: "Actividad *"
                        Row(
                          children: [
                            Text(
                              'Actividad',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const Text(
                              ' *',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Input 1: Activity Dropdown (Full Width)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? theme.scaffoldBackgroundColor.withValues(alpha: 0.5)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                            ),
                          ),
                          child: _activities.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    'No hay actividades disponibles en la API',
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                )
                              : DropdownButtonHideUnderline(
                                  child: DropdownButton<ActivityEntity>(
                                    value: _selectedActivity,
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
                                    items: _activities.map((act) {
                                      return DropdownMenuItem<ActivityEntity>(
                                        value: act,
                                        child: Text(
                                          act.name,
                                          style: const TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) async {
                                      if (val != null && val != _selectedActivity) {
                                        setState(() {
                                          _selectedActivity = val;
                                        });
                                        await _fetchSubactivitiesForSelectedActivity(val.id);
                                        if (mounted) {
                                          setState(() {});
                                        }
                                      }
                                    },
                                  ),
                                ),
                        ),

                        const SizedBox(height: 24),

                        // Label 2: "Sub actividad: *"
                        Row(
                          children: [
                            Text(
                              'Sub actividad:',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const Text(
                              ' *',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Input 2: Subactivity Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: context.isDarkMode
                                ? theme.scaffoldBackgroundColor.withValues(alpha: 0.5)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                            ),
                          ),
                          child: _subactivities.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    'No hay subactividades disponibles para esta actividad',
                                    style: TextStyle(color: Colors.grey, fontSize: 13),
                                  ),
                                )
                              : DropdownButtonHideUnderline(
                                  child: DropdownButton<SubactivityEntity>(
                                    value: _selectedSubactivity,
                                    isExpanded: true,
                                    icon: const Icon(Icons.arrow_drop_down_rounded, size: 28),
                                    items: _subactivities.map((sub) {
                                      return DropdownMenuItem<SubactivityEntity>(
                                        value: sub,
                                        child: Text(
                                          sub.name,
                                          style: const TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedSubactivity = val;
                                        });
                                      }
                                    },
                                  ),
                                ),
                        ),

                        const SizedBox(height: 32),

                        // Action Button: "Iniciar Actividad"
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _handleActivityToggle,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
                              shape: const StadiumBorder(),
                            ),
                            child: _isSaving
                                ? const AppLoader(size: 24, color: Colors.white)
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_circle_fill_rounded,
                                        size: 22,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Iniciar Actividad',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms, delay: 100.ms).slideY(begin: 0.05, end: 0),
                ],
              ),
            ),
    );
  }
}
