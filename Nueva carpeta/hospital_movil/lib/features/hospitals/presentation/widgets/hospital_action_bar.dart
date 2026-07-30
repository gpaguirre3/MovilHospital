import 'package:flutter/material.dart';
import '../../../../shared/extensions/context_extensions.dart';

class HospitalActionBar extends StatelessWidget {
  final bool isAllSelected;
  final int selectedCount;
  final VoidCallback onApply;
  final VoidCallback onToggleSelectAll;

  const HospitalActionBar({
    super.key,
    required this.isAllSelected,
    required this.selectedCount,
    required this.onApply,
    required this.onToggleSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    // Sage / Emerald Green Pill Button Style
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      elevation: 3,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.4),
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(vertical: 14),
    );

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decorative subtle top border line
            Container(
              height: 1,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            ),
            const SizedBox(height: 14),

            // Two Big Pill Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  // "Aplicar" Button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: onApply,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Aplicar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (selectedCount > 0) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$selectedCount',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // "Todos" / "Ninguno" Button
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: onToggleSelectAll,
                        child: Text(
                          isAllSelected ? 'Ninguno' : 'Todos',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Curved Decorative Light Grey Bottom Bar / Curve
            CustomPaint(
              size: const Size(double.infinity, 16),
              painter: BottomCurvePainter(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.grey.withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Decorative subtle grey curve painter at the bottom
class BottomCurvePainter extends CustomPainter {
  final Color color;
  BottomCurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.1,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
