import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/router/routes.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_loader.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/hospitals_bloc.dart';
import '../bloc/hospitals_event.dart';
import '../bloc/hospitals_state.dart';
import '../widgets/hospital_action_bar.dart';
import '../widgets/hospital_drawer.dart';
import '../widgets/hospital_item_tile.dart';
import '../widgets/hospital_search_bar.dart';

class HospitalsScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const HospitalsScreen({
    super.key,
    required this.onThemeToggle,
  });

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HospitalsBloc>().add(FetchHospitalsRequested());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onApplySelection(BuildContext context, Set<int> selectedIds, int totalCount) {
    if (selectedIds.isEmpty) {
      return;
    }

    // Navigate directly to Assignments screen upon applying selection
    Navigator.pushNamed(context, Routes.assignments);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is Unauthenticated) {
          Navigator.pushReplacementNamed(context, Routes.login);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            'Hospitales',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        drawer: HospitalDrawer(onThemeToggle: widget.onThemeToggle),
        body: BlocBuilder<HospitalsBloc, HospitalsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLoader(size: 36),
                    SizedBox(height: 16),
                    Text(
                      'Cargando hospitales asociados...',
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
                      Icon(Icons.error_outline_rounded, size: 48, color: theme.colorScheme.error),
                      const SizedBox(height: 16),
                      Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.read<HospitalsBloc>().add(FetchHospitalsRequested());
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
                // Header section & search bar container
                Container(
                  color: theme.colorScheme.surface,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Subtitle & Counter Badge
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hospitales Asociados',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          // Counter Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              '${state.selectedCount} de ${state.totalCount} seleccionados',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Underline Search Field
                      HospitalSearchBar(
                        controller: _searchController,
                        onChanged: (val) {
                          context.read<HospitalsBloc>().add(SearchQueryChanged(val));
                        },
                        onClear: () {
                          _searchController.clear();
                          context.read<HospitalsBloc>().add(ClearSearchRequested());
                        },
                      ),
                    ],
                  ),
                ),

                // Hospital List section
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: state.filteredHospitals.isEmpty
                        ? Center(
                            key: const ValueKey('empty'),
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 56,
                                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No se encontraron resultados',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Intenta buscar por otro nombre, código o barrio',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            key: const ValueKey('list'),
                            padding: const EdgeInsets.only(top: 8, bottom: 16),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.filteredHospitals.length,
                            itemBuilder: (context, index) {
                              final hospital = state.filteredHospitals[index];
                              final isSelected = state.selectedIds.contains(hospital.id);

                              return HospitalItemTile(
                                hospital: hospital,
                                isSelected: isSelected,
                                onChanged: (_) {
                                  context
                                      .read<HospitalsBloc>()
                                      .add(ToggleHospitalSelection(hospital.id));
                                },
                              );
                            },
                          ),
                  ),
                ),

                // Fixed Bottom Action Bar
                HospitalActionBar(
                  isAllSelected: state.isAllSelected,
                  selectedCount: state.selectedCount,
                  onApply: () {
                    _onApplySelection(context, state.selectedIds, state.totalCount);
                  },
                  onToggleSelectAll: () {
                    context.read<HospitalsBloc>().add(ToggleSelectAllRequested());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
