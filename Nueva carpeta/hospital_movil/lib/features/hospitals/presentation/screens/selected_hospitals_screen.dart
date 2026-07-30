import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../bloc/hospitals_bloc.dart';
import '../bloc/hospitals_state.dart';

class SelectedHospitalsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const SelectedHospitalsScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  State<SelectedHospitalsScreen> createState() => _SelectedHospitalsScreenState();
}

class _SelectedHospitalsScreenState extends State<SelectedHospitalsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filterQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Monitoreo de Hospitales',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -0.3,
          ),
        ),
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
        builder: (context, state) {
          final selectedHospitals = state.selectedHospitals;

          final displayedHospitals = selectedHospitals.where((h) {
            if (_filterQuery.trim().isEmpty) return true;
            final q = _filterQuery.toLowerCase();
            return h.name.toLowerCase().contains(q) ||
                h.id.toString().contains(q) ||
                h.direction.toLowerCase().contains(q);
          }).toList();

          return Column(
            children: [
              // Top Header Panel & Search Control
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Subtitle & Active Count Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Búsqueda y Navegación',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4CAF50), // Active Status Dot
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${displayedHospitals.length} Activos',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Modern Floating Search Input
                    Container(
                      decoration: BoxDecoration(
                        color: context.isDarkMode
                            ? theme.scaffoldBackgroundColor.withValues(alpha: 0.5)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                        ),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _filterQuery = val;
                          });
                        },
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: 'Nombre del Hospital o dirección...',
                          hintStyle: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.cancel_rounded, size: 20),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _filterQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Modern Interactive Action Cards ("Ubicación del hospital" & "Ruta a tomar")
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.near_me_rounded, color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Ubicación del hospital',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.directions_rounded,
                                      color: theme.colorScheme.primary, size: 18),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'Ruta a tomar',
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: -0.1, end: 0, duration: 500.ms),

              const SizedBox(height: 16),

              // Section Subtitle Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.local_hospital_rounded,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Hospitales Seleccionados',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Hospital Cards List View
              Expanded(
                child: displayedHospitals.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.domain_disabled_rounded,
                              size: 56,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No se encontraron hospitales',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedHospitals.length,
                        itemBuilder: (context, index) {
                          final hospital = displayedHospitals[index];

                          return Card(
                            elevation: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            color: theme.colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.registro,
                                  arguments: hospital,
                                );
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left Avatar / Medical Badge Icon
                                    Container(
                                      width: 52,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: theme.colorScheme.primary.withValues(alpha: 0.25),
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.local_hospital_rounded,
                                              color: theme.colorScheme.primary,
                                              size: 22,
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '#${hospital.id}',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: theme.colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Center Hospital Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Hospital Name
                                          Text(
                                            hospital.name.toUpperCase(),
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                              height: 1.2,
                                              color: theme.colorScheme.onSurface,
                                            ),
                                          ),
                                          const SizedBox(height: 6),

                                          // Address Row
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 15,
                                                color: theme.colorScheme.primary,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  '${hospital.direction}${hospital.barrio != null ? ", ${hospital.barrio}" : ""}',
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    height: 1.3,
                                                    color: theme.colorScheme.onSurface
                                                        .withValues(alpha: 0.65),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    // Action Arrow Icon Button
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: theme.colorScheme.primary,
                                      ),
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
