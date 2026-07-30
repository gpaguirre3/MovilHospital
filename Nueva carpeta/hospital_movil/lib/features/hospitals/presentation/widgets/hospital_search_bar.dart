import 'package:flutter/material.dart';

class HospitalSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const HospitalSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          filled: false,
          hintText: 'Buscar hospital por: Nombre, Id, Dirección',
          hintStyle: TextStyle(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: theme.colorScheme.primary,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.cancel_rounded,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    size: 20,
                  ),
                  onPressed: onClear,
                )
              : null,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.0,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
