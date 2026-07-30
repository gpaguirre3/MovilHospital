import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double size;
  final Color? color;

  const AppLoader({
    super.key,
    this.size = 24.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? AppColors.primarySage,
        ),
      ),
    );
  }
}
