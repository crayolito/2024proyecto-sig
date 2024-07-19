import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';

class MapLoading extends StatelessWidget {
  const MapLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Text("Cargando mapa, por favor un momento",
                style: estilosText!.titulo2, textAlign: TextAlign.center)));
  }
}
