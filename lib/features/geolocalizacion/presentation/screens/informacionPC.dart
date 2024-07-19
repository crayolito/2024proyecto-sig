import 'dart:async';

import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/features/showLoadingCustom/showLoadingCustom.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoPuntoCorte extends StatefulWidget {
  const InfoPuntoCorte({super.key});

  @override
  State<InfoPuntoCorte> createState() => _InfoPuntoCorteState();
}

class _InfoPuntoCorteState extends State<InfoPuntoCorte> {
  String? estadoSeleccionado;
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    _subscription = autheticationBloc.stream.listen((event) {
      if (event.procesoAuthentication == ProcesoAuthentication.correcto) {
        ShowLoadingCustom.showLoadingProcessUpdateSuccess(context);
      }
      if (event.procesoAuthentication == ProcesoAuthentication.error) {
        ShowLoadingCustom.showLoadingProcessUpdateError(context);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    final data = autheticationBloc.state.dataCorte;

    List<String> estadosCorte = [
      "SE CORTO SERVICIO",
      "SE RETRASO EL CORTE",
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://res.cloudinary.com/da9xsfose/image/upload/v1721392744/eop1eieffbjmch33haht.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.15,
                left: size.width * 0.15,
                child: Container(
                  height: size.height * 0.7,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Detalles P.C.",
                        style: estilosText!.tituloInfoPuntoCorte,
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        height: size.height * 0.63,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Codigo de corte",
                              style: estilosText!.subTituloInfoPuntoCorte,
                            ),
                            Text(data!.data1,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: estilosText!.subTituloInfoPuntoCorte2),
                            Text(
                              "Cliente nombre",
                              textAlign: TextAlign.center,
                              style: estilosText!.subTituloInfoPuntoCorte,
                            ),
                            Text(data.nombre,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: estilosText!.subTituloInfoPuntoCorte2),
                            Text(
                              "Medidor",
                              style: estilosText!.subTituloInfoPuntoCorte,
                            ),
                            Text(data.data2,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: estilosText!.subTituloInfoPuntoCorte2),
                            Text(
                              "Estado servicio",
                              style: estilosText!.subTituloInfoPuntoCorte,
                            ),
                            Text(data.data7.trim(),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: estilosText!.subTituloInfoPuntoCorte2),
                            Text(
                              "Tipo de vivienda",
                              style: estilosText!.subTituloInfoPuntoCorte,
                            ),
                            Text(data.data8.trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: estilosText!.subTituloInfoPuntoCorte2),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Center(
                              child: DropdownButtonHideUnderline(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: DropdownButton<String>(
                                    value: estadoSeleccionado,
                                    hint: Text("Estado del corte",
                                        style: estilosText!
                                            .subTituloInfoPuntoCorte),
                                    onChanged: (String? nuevoValor) {
                                      setState(() {
                                        estadoSeleccionado = nuevoValor;
                                      });
                                    },
                                    items: estadosCorte
                                        .map<DropdownMenuItem<String>>(
                                            (String valor) {
                                      return DropdownMenuItem<String>(
                                        value: valor,
                                        child: Text(valor),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    autheticationBloc.add(
                                        OnActualizatPuntoCorte(data.data1));
                                  },
                                  icon: Icon(Icons.save,
                                      color: kSecondaryColor,
                                      size: size.width * 0.1),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.cancel,
                                      color: kSecondaryColor,
                                      size: size.width * 0.1),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
