import 'dart:convert';
import 'dart:math';

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FuncionesAyuda {
  static double calcularDistancia(LatLng puntoA, LatLng puntoB) {
    var factorConversion = 0.017453292519943295; // Pi / 180
    var calculo = 0.5 -
        cos((puntoB.latitude - puntoA.latitude) * factorConversion) / 2 +
        cos(puntoA.latitude * factorConversion) *
            cos(puntoB.latitude * factorConversion) *
            (1 -
                cos((puntoB.longitude - puntoA.longitude) * factorConversion)) /
            2;
    return 12742 * asin(sqrt(calculo)); // 2 * R; R = 6371 km
  }

  static List<LatLng> filtrarPuntosCorteUtiles(List<LatLng> listaPuntosCorte) {
    // Elimina objetos donde latitud o longitud sean 0 y elimina duplicados
    var puntosUnicosFiltrados = <String, LatLng>{};

    for (var puntoActual in listaPuntosCorte) {
      if (puntoActual.latitude != 0 && puntoActual.longitude != 0) {
        // Usa una representación en string de LatLng como clave para asegurar unicidad
        String claveUnica = '${puntoActual.latitude},${puntoActual.longitude}';
        if (!puntosUnicosFiltrados.containsKey(claveUnica)) {
          puntosUnicosFiltrados[claveUnica] = puntoActual;
        }
      }
    }

    var umbralDistanciaMinima = 0.5;
    var listaPuntosFiltrados = <LatLng>[];

    for (var puntoEvaluado in puntosUnicosFiltrados.values) {
      bool esPuntoCercano = listaPuntosFiltrados.any((punto) =>
          calcularDistancia(punto, puntoEvaluado) < umbralDistanciaMinima);
      if (!esPuntoCercano) {
        listaPuntosFiltrados.add(puntoEvaluado);
      }
    }

    return listaPuntosFiltrados;
  }

  static String convertTravelMode(TipoTransporte tipoTransporte) {
    switch (tipoTransporte) {
      case TipoTransporte.carro:
        return 'DRIVE';
      case TipoTransporte.bicicleta:
        return 'BICYCLE';
      case TipoTransporte.caminar:
        return 'WALK';
      case TipoTransporte.moto:
        return 'TWO_WHEELER';
    }
  }

  static String convertRoutingPreference(NivelTrafico nivelTrafico) {
    switch (nivelTrafico) {
      case NivelTrafico.con:
        return 'TRAFFIC_AWARE';
      case NivelTrafico.sin:
        return 'TRAFFIC_UNAWARE';
      case NivelTrafico.optimo:
        return 'TRAFFIC_AWARE_OPTIMAL';
    }
  }

  static String puntosIntermedioBody(List<LatLng> puntosCorte) {
    var puntos = puntosCorte.take(puntosCorte.length - 1).map((punto) {
      return {
        "location": {
          "latLng": {
            "latitude": punto.latitude,
            "longitude": punto.longitude,
          }
        }
      };
    }).toList();

    return jsonEncode(puntos);
  }
}
