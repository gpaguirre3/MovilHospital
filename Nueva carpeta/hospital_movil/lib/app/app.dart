import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/config/env.dart';
import '../core/theme/app_theme.dart';
import '../features/activities/presentation/bloc/activities_bloc.dart';
import '../features/assignments/presentation/bloc/assignments_bloc.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/auth/presentation/bloc/auth_event.dart';
import '../features/hospitals/presentation/bloc/hospitals_bloc.dart';
import '../features/records/presentation/bloc/records_bloc.dart';
import 'di/injection_container.dart';
import 'router/app_router.dart';
import 'router/routes.dart';

class MovilHospitalApp extends StatefulWidget {
  const MovilHospitalApp({super.key});

  @override
  State<MovilHospitalApp> createState() => _MovilHospitalAppState();
}

class _MovilHospitalAppState extends State<MovilHospitalApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        final isPlatformDark =
            WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
        _themeMode = isPlatformDark ? ThemeMode.light : ThemeMode.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(CheckAuthStatusRequested()),
        ),
        BlocProvider<HospitalsBloc>(
          create: (context) => sl<HospitalsBloc>(),
        ),
        BlocProvider<AssignmentsBloc>(
          create: (context) => sl<AssignmentsBloc>(),
        ),
        BlocProvider<RecordsBloc>(
          create: (context) => sl<RecordsBloc>(),
        ),
        BlocProvider<ActivitiesBloc>(
          create: (context) => sl<ActivitiesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: Env.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: _themeMode,
        initialRoute: Routes.initial,
        onGenerateRoute: (settings) => AppRouter.generateRoute(
          settings,
          onThemeToggle: _toggleTheme,
        ),
      ),
    );
  }
}
