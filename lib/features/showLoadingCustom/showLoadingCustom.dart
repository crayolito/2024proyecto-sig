import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowLoadingCustom {
  static void showLoadingMap(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: kPrimaryColor, width: 3)),
            title: Text(
              "Espere por favor",
              textAlign: TextAlign.center,
              style: estilosText!.titulo2,
            ),
            content: SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.1,
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(kSecondaryColor),
                ),
              ),
            ),
          );
        });
  }

  static void showLoadingProcesoRutas(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return BlocListener<AutheticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state.procesoCambioRuta ==
                    ProcesoCambioRuta.procesoFinalizado) {
                  googleMapBloc.add(OnInitFigureMap(context));
                  Navigator.pop(context);
                }
              },
              child: AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: kPrimaryColor, width: 3)),
                title: Text(
                  "Espere por favor",
                  textAlign: TextAlign.center,
                  style: estilosText!.titulo2,
                ),
                content: SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.1,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(kSecondaryColor),
                    ),
                  ),
                ),
              ));
        });
  }

  static void showLoadingAuthSnackBar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text("Usuario o contraseña incorrectos"),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showLoadingProcessUpdateSuccess(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  autheticationBloc
                      .add(OnChangedProccessAuth(ProcesoAuthentication.none));
                },
                icon: Icon(
                  FontAwesomeIcons.checkToSlot,
                  color: kSecondaryColor,
                  size: 60,
                ),
              )),
            ),
          );
        });
  }

  static void showLoadingProcessUpdateError(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);

          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      autheticationBloc.add(
                          OnChangedProccessAuth(ProcesoAuthentication.none));
                    },
                    icon: Icon(
                      FontAwesomeIcons.triangleExclamation,
                      color: Colors.amber,
                      size: 60,
                    )),
              ),
            ),
          );
        });
  }
}
