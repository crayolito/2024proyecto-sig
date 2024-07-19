import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/config/constant/shadow.constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EstilosLetras {
  BuildContext context;

  EstilosLetras(this.context);

  Size get size => MediaQuery.of(context).size;

  // HOME(SCREEN) AUTHENTICATION
  TextStyle get tituloAuth => GoogleFonts.courierPrime(
      fontSize: size.width * 0.1,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      shadows: shadowKS);

  TextStyle get subTituloAuth => GoogleFonts.courierPrime(
        fontSize: size.width * 0.06,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get letraInput => GoogleFonts.courierPrime(
        fontSize: size.width * 0.06,
        color: kPrimaryColor,
      );

  TextStyle get buttonLetra => GoogleFonts.courierPrime(
        fontSize: size.width * 0.06,
        color: Colors.white,
      );

  TextStyle get registroLetra1 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.045,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get registroLetra2 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.04,
        color: kPrimaryColor,
      );

  // // // // // //

  // TIPOS DE MAPAS
  TextStyle get tituloTipoMapa => GoogleFonts.courierPrime(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloTipoMapa1 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.05,
        color: kSecondaryColor,
      );

  TextStyle get subTituloTipoMapa2 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.05,
        color: kPrimaryColor,
      );

  // // // // // //

  // OPCIONES DE FILTRO DE RUTA
  TextStyle get tituloFiltroRuta => GoogleFonts.courierPrime(
        fontSize: size.width * 0.07,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titulo2FiltroRuta => GoogleFonts.courierPrime(
        fontSize: size.width * 0.055,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloFiltroRuta => GoogleFonts.courierPrime(
        fontSize: size.width * 0.05,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloFiltroRutaSeleccionado => GoogleFonts.courierPrime(
      fontSize: size.width * 0.05,
      color: kPrimaryColor,
      fontWeight: FontWeight.bold,
      shadows: shadowKS);

  TextStyle get subTitulo2FiltroRuta => GoogleFonts.courierPrime(
        fontSize: size.width * 0.05,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titulo => GoogleFonts.courierPrime(
      fontSize: size.width * 0.05,
      fontWeight: FontWeight.bold,
      color: kSecondaryColor,
      shadows: shadowKP);

  TextStyle get titulo2 => GoogleFonts.courierPrime(
      fontSize: size.width * 0.07, color: kSecondaryColor, shadows: shadowKP);

  TextStyle get titulo3 => GoogleFonts.courierPrime(
      fontSize: size.width * 0.06, color: kSecondaryColor);

  TextStyle get titulo4 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.06,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get tituloItemPC => GoogleFonts.courierPrime(
        fontSize: size.width * 0.054,
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloItemPC => GoogleFonts.courierPrime(
        fontSize: size.width * 0.05,
        color: kPrimaryColor,
      );

  // SCREEN INFORMACION DE PUNTOS DE CORTE
  TextStyle get tituloInfoPuntoCorte => GoogleFonts.courierPrime(
        fontSize: size.width * 0.07,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloInfoPuntoCorte => GoogleFonts.courierPrime(
        fontSize: size.width * 0.055,
        color: kSecondaryColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subTituloInfoPuntoCorte2 => GoogleFonts.courierPrime(
        fontSize: size.width * 0.055,
        color: kSecondaryColor,
      );
}
