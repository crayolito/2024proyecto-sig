import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.placeholder,
    required this.icon,
    required this.color,
    required this.keyboardType,
    required this.onChanged,
    this.obscureText = false,
  });

  final bool? obscureText;
  final String placeholder;
  final IconData icon;
  final Color color;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
        labelText: placeholder,
        labelStyle: estilosText!.letraInput,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kCColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        focusColor: kPrimaryColor,
        isDense: true);

    return TextFormField(
        obscureText: obscureText!,
        cursorColor: kPrimaryColor,
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: estilosText!.letraInput,
        decoration: decoration);
  }
}
