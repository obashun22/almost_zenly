import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String labelText;
  final bool obscureText;

  const AuthTextFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.labelText = '',
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        labelText: labelText,
      ),
    );
  }
}
