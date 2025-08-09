import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.onChanged,
    this.obscureText = false,
    this.validator,
  });
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(labelText),
      ),
    );
  }
}
