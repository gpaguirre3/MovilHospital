import 'package:flutter/material.dart';
import '../../domain/entities/hospital.dart';

class HospitalItemTile extends StatelessWidget {
  final Hospital hospital;
  final bool isSelected;
  final ValueChanged<bool?> onChanged;

  const HospitalItemTile({
    super.key,
    required this.hospital,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Color logic as requested:
    // Unselected items are dark/black text. Selected items display muted grey text.
    final textColor = isSelected
        ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
        : theme.colorScheme.onSurface;

    return Column(
      children: [
        CheckboxListTile(
          value: isSelected,
          onChanged: onChanged,
          controlAffinity: ListTileControlAffinity.leading,
          isThreeLine: true,
          activeColor: theme.colorScheme.primary,
          checkColor: Colors.white,
          side: BorderSide(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            width: 1.5,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${hospital.id} ',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                        : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                TextSpan(
                  text: '${hospital.name.toUpperCase()})',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              hospital.fullAddressText,
              style: TextStyle(
                fontSize: 13,
                height: 1.3,
                color: isSelected
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.4)
                    : theme.colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 0.8,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ],
    );
  }
}
