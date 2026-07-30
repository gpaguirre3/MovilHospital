import 'package:flutter/material.dart';
import '../../domain/entities/assignment.dart';
import 'assignment_card.dart';

class AssignmentListTile extends StatelessWidget {
  final Assignment assignment;
  final VoidCallback onTap;

  const AssignmentListTile({
    super.key,
    required this.assignment,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = AssignmentItemConfig.getConfig(assignment.name);

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
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            children: [
              // Pastel Icon Box (Image 2 representation)
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: config.backgroundColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Icon(
                    config.icon,
                    size: 30,
                    color: config.iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title and Description text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      assignment.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      assignment.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Chevron Right Arrow Icon
              Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
