import 'package:flutter/material.dart';
import '../../features/activities/domain/entities/activity_entity.dart';
import '../../features/assignments/presentation/screens/assignments_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/hospitals/domain/entities/hospital.dart';
import '../../features/hospitals/presentation/screens/hospitals_screen.dart';
import '../../features/hospitals/presentation/screens/selected_hospitals_screen.dart';
import '../../features/records/domain/entities/record_entity.dart';
import '../../features/records/presentation/screens/ejecucion_actividad_screen.dart';
import '../../features/records/presentation/screens/inicio_actividad_screen.dart';
import '../../features/records/presentation/screens/registro_screen.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    required VoidCallback onThemeToggle,
  }) {
    switch (settings.name) {
      case Routes.login:
      case Routes.initial:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => LoginScreen(onThemeToggle: onThemeToggle),
        );
      case Routes.hospitals:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HospitalsScreen(onThemeToggle: onThemeToggle),
        );
      case Routes.assignments:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AssignmentsScreen(onThemeToggle: onThemeToggle),
        );
      case Routes.selectedHospitals:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SelectedHospitalsScreen(onThemeToggle: onThemeToggle),
        );
      case Routes.registro:
        final hospital = settings.arguments as Hospital?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RegistroScreen(
            hospital: hospital,
            onThemeToggle: onThemeToggle,
          ),
        );
      case Routes.inicioActividad:
        final args = settings.arguments as Map<String, dynamic>?;
        final record = args?['record'] as RecordEntity?;
        final hospital = args?['hospital'] as Hospital?;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => InicioActividadScreen(
            record: record,
            hospital: hospital,
            onThemeToggle: onThemeToggle,
          ),
        );
      case Routes.ejecucionActividad:
        final args = settings.arguments as Map<String, dynamic>?;
        final processActivityId = args?['processActivityId'] as int?;
        final activity = args?['activity'] as ActivityEntity?;
        final subactivity = args?['subactivity'] as SubactivityEntity?;
        final hospital = args?['hospital'] as Hospital?;
        final record = args?['record'] as RecordEntity?;
        final startTime = args?['startTime'] as String?;
        final startTimeIso = args?['startTimeIso'] as String?;
        final history = args?['history'] as List<ActivityHistoryItem>?;

        return MaterialPageRoute(
          settings: settings,
          builder: (_) => EjecucionActividadScreen(
            processActivityId: processActivityId,
            activity: activity,
            subactivity: subactivity,
            hospital: hospital,
            record: record,
            startTime: startTime,
            startTimeIso: startTimeIso,
            history: history,
            onThemeToggle: onThemeToggle,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
