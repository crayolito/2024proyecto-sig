import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';

class ButtonAuthentication extends StatelessWidget {
  const ButtonAuthentication({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final decoration = BoxDecoration(
      color: kSecondaryColor,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: size.height * 0.07,
        width: size.width * 0.35,
        decoration: decoration,
        child: Text(
          "Ingresar",
          style: estilosText!.buttonLetra,
        ),
      ),
    );
  }
}
