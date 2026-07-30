import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../hospitals/domain/entities/hospital.dart';
import '../bloc/records_bloc.dart';
import '../bloc/records_event.dart';
import '../bloc/records_state.dart';

class RegistroScreen extends StatefulWidget {
  final Hospital? hospital;
  final VoidCallback onThemeToggle;

  const RegistroScreen({
    super.key,
    this.hospital,
    required this.onThemeToggle,
  });

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecordsBloc>().add(const FetchRecordsRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Registro de hospitales'),
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
      body: BlocBuilder<RecordsBloc, RecordsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppLoader(size: 36),
                  SizedBox(height: 16),
                  Text(
                    'Cargando registros del servidor...',
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
                            .read<RecordsBloc>()
                            .add(const FetchRecordsRequested());
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final records = state.records;

          return Column(
            children: [
              const SizedBox(height: 28),

              // Title Section Header: "REGISTRO"
              Center(
                child: Text(
                  'REGISTRO DE ACTIVIDAD',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // List View of Records loaded from Java Backend Database (/api/records)
              Expanded(
                child: records.isEmpty
                    ? Center(
                        child: Text(
                          'No hay registros disponibles',
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 8, bottom: 24),
                        physics: const BouncingScrollPhysics(),
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          final record = records[index];
                          final lowerName = record.name.toLowerCase();
                          final isReport = lowerName.contains('report');

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.inicioActividad,
                                  arguments: {
                                    'record': record,
                                    'hospital': widget.hospital,
                                  },
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 16.0),
                                child: Row(
                                  children: [
                                    // Pastel Icon Container (Exact Image Replica)
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: isReport
                                            ? const Color(0xFFE1BEE7) // Pastel Purple
                                            : const Color(0xFFDCEDC8), // Pastel Green
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          isReport
                                              ? Icons.bar_chart_rounded
                                              : Icons.assignment_turned_in_rounded,
                                          size: 30,
                                          color: isReport
                                              ? const Color(0xFF4A148C) // Dark Purple
                                              : const Color(0xFF1B5E20), // Dark Green
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Title & Subtitle Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            record.name.toLowerCase(),
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16,
                                              color: theme.colorScheme.onSurface,
                                              letterSpacing: -0.2,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            record.description.toLowerCase(),
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontSize: 13,
                                              color: theme.colorScheme.onSurface
                                                  .withValues(alpha: 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    // Chevron Right Arrow
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.35),
                                      size: 26,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 400.ms, delay: (index * 60).ms)
                              .slideX(begin: 0.05, end: 0);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
