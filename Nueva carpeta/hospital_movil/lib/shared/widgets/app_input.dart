import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onFieldSubmitted;

  const AppInput({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              prefixIcon,
              color: theme.colorScheme.primary.withValues(alpha: 0.8),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
