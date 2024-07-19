import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:app_sig2024/config/constant/shadow.constant.dart';
import 'package:app_sig2024/features/geolocalizacion/domain/entities/lugar-corte.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/itemSearchBar.dart';
import 'package:app_sig2024/features/showLoadingCustom/showLoadingCustom.dart';
import 'package:app_sig2024/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          context.pop();
        },
        child: Container(
          decoration: const BoxDecoration(
            color: kTerciaryColor, // Color de fondo
            shape: BoxShape.circle, // Forma circular
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                8.0), // Ajusta el valor del relleno según necesites
            child: Icon(
              Icons.arrow_back,
              color: kPrimaryColor,
              size: size.width * 0.08,
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Stack(
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    // NOTE: Navbar de la pantalla de busqueda
                    const NavbarCustom(),
                    Container(
                        margin: EdgeInsets.only(top: size.height * 0.01),
                        padding: EdgeInsets.only(
                            left: size.width * 0.015,
                            right: size.width * 0.015,
                            bottom: size.height * 0.005),
                        height: size.height * 0.83,
                        width: size.width,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: autheticationBloc.state.verCliente.length,
                          itemBuilder: (context, index) {
                            final puntoCorte =
                                autheticationBloc.state.verCliente[index];

                            return ItemPuntoCorte(
                              puntoCorte: puntoCorte,
                              index: index,
                            );
                          },
                        )),
                  ],
                ),
              ),
              //  NOTE: Filtrado de los items de la lista de puntos de corte
              const SearchBarComponent(),
            ],
          ),
        ),
      ),
    );
  }
}

class NavbarCustom extends StatefulWidget {
  const NavbarCustom({
    super.key,
  });

  @override
  State<NavbarCustom> createState() => _NavbarCustomState();
}

class _NavbarCustomState extends State<NavbarCustom> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.015,
      ),
      width: size.width,
      height: size.height * 0.16,
      color: kPrimaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Lista de cortes",
            style: estilosText!.titulo4,
          ),
        ],
      ),
    );
  }
}

class ButtonsFiltroRutaCorte extends StatelessWidget {
  const ButtonsFiltroRutaCorte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc = BlocProvider.of<AutheticationBloc>(context);
    return SizedBox(
      height: size.height * 0.07,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(kPrimaryColor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {},
            child: Text("Reset", style: estilosText!.subTitulo2FiltroRuta),
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(kPrimaryColor),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              context.pop();
              ShowLoadingCustom.showLoadingProcesoRutas(context);
              autheticationBloc.add(const OnUpdatePuntosCorte());
            },
            child: Text("Aplicar", style: estilosText!.subTitulo2FiltroRuta),
          )
        ],
      ),
    );
  }
}

class FiltroRutaAlternativa extends StatelessWidget {
  const FiltroRutaAlternativa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);

    return Container(
        height: size.height * 0.07,
        width: size.width,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text("Rutas Alternativas", style: estilosText!.titulo2FiltroRuta),
            Checkbox(
              activeColor: kPrimaryColor,
              value: autheticationBloc.state.showAlternativa,
              onChanged: (value) {
                autheticationBloc.add(OnChangedFiltroRutaCorte(
                    showAlternativa: !autheticationBloc.state.showAlternativa));
              },
            ),
          ],
        ));
  }
}

class FiltroRutaCorte extends StatefulWidget {
  const FiltroRutaCorte({
    super.key,
  });

  @override
  State<FiltroRutaCorte> createState() => _FiltroRutaCorteState();
}

class _FiltroRutaCorteState extends State<FiltroRutaCorte> {
  late int tipoRuta;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);
    tipoRuta = autheticationBloc.state.tipoRuta;
    controller.value = TextEditingValue(
      text: tipoRuta.toString(),
    );

    final decoration = InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kCColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        focusColor: kPrimaryColor,
        isDense: true);

    return SizedBox(
      height: size.height * 0.067,
      width: size.width,
      child: Row(
        children: [
          Text("Escoger Ruta : ", style: estilosText!.titulo2FiltroRuta),
          SizedBox(
            width: size.width * 0.02,
          ),
          SizedBox(
              width: size.width * 0.18,
              child: TextFormField(
                readOnly: true,
                controller: controller,
                cursorColor: kSecondaryColor,
                style: estilosText!.letraInput,
                textAlign: TextAlign.center,
                decoration: decoration,
              )),
          SizedBox(
            width: size.width * 0.03,
          ),
          IconButton(
              onPressed: () {
                if (tipoRuta <= 1) return;
                setState(() {
                  tipoRuta--;
                  controller.value = TextEditingValue(
                    text: tipoRuta.toString(),
                  );
                });
                autheticationBloc
                    .add(OnChangedFiltroRutaCorte(tipoRuta: tipoRuta));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
                size: size.width * 0.08,
              )),
          IconButton(
              onPressed: () {
                if (tipoRuta >= 9) return;
                setState(() {
                  tipoRuta++;
                  controller.value = TextEditingValue(
                    text: tipoRuta.toString(),
                  );
                });
                autheticationBloc
                    .add(OnChangedFiltroRutaCorte(tipoRuta: tipoRuta));
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: kPrimaryColor,
                size: size.width * 0.08,
              ))
        ],
      ),
    );
  }
}

class FiltroTrafico extends StatelessWidget {
  const FiltroTrafico({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      height: size.height * 0.1,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Preferencia de Trafico",
                style: estilosText!.titulo2FiltroRuta),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                  onTap: () {
                    autheticationBloc.add(const OnChangedFiltroRutaCorte(
                        nivelTrafico: NivelTrafico.con));
                  },
                  child: Text("CON",
                      style: autheticationBloc.state.tipoTrafico ==
                              NivelTrafico.con
                          ? estilosText!.subTituloFiltroRutaSeleccionado
                          : estilosText!.subTituloFiltroRuta)),
              GestureDetector(
                  onTap: () {
                    autheticationBloc.add(const OnChangedFiltroRutaCorte(
                        nivelTrafico: NivelTrafico.sin));
                  },
                  child: Text("SIN",
                      style: autheticationBloc.state.tipoTrafico ==
                              NivelTrafico.sin
                          ? estilosText!.subTituloFiltroRutaSeleccionado
                          : estilosText!.subTituloFiltroRuta)),
              GestureDetector(
                  onTap: () {
                    autheticationBloc.add(const OnChangedFiltroRutaCorte(
                        nivelTrafico: NivelTrafico.optimo));
                  },
                  child: Text("OPTIMO",
                      style: autheticationBloc.state.tipoTrafico ==
                              NivelTrafico.optimo
                          ? estilosText!.subTituloFiltroRutaSeleccionado
                          : estilosText!.subTituloFiltroRuta)),
            ],
          )
        ],
      ),
    );
  }
}

class FiltroTransporte extends StatelessWidget {
  const FiltroTransporte({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);

    return SizedBox(
      height: size.height * 0.1,
      width: size.width,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Medio de Transporte",
                style: estilosText!.titulo2FiltroRuta),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  autheticationBloc.add(const OnChangedFiltroRutaCorte(
                      tipoTransporte: TipoTransporte.caminar));
                },
                icon: Icon(
                  FontAwesomeIcons.walking,
                  size: size.width * 0.08,
                  color: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.caminar
                      ? kPrimaryColor
                      : kSecondaryColor,
                  shadows: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.caminar
                      ? shadowKSN2
                      : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  autheticationBloc.add(const OnChangedFiltroRutaCorte(
                      tipoTransporte: TipoTransporte.bicicleta));
                },
                icon: Icon(
                  FontAwesomeIcons.bicycle,
                  size: size.width * 0.08,
                  color: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.bicicleta
                      ? kPrimaryColor
                      : kSecondaryColor,
                  shadows: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.bicicleta
                      ? shadowKSN2
                      : null,
                ),
              ),
              IconButton(
                onPressed: () {
                  autheticationBloc.add(const OnChangedFiltroRutaCorte(
                      tipoTransporte: TipoTransporte.carro));
                },
                icon: Icon(
                  FontAwesomeIcons.car,
                  size: size.width * 0.08,
                  color: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.carro
                      ? kPrimaryColor
                      : kSecondaryColor,
                  shadows: autheticationBloc.state.tipoTransporte ==
                          TipoTransporte.carro
                      ? shadowKSN2
                      : null,
                ),
              ),
              IconButton(
                  onPressed: () {
                    autheticationBloc.add(const OnChangedFiltroRutaCorte(
                        tipoTransporte: TipoTransporte.moto));
                  },
                  icon: Icon(
                    FontAwesomeIcons.motorcycle,
                    size: size.width * 0.08,
                    color: autheticationBloc.state.tipoTransporte ==
                            TipoTransporte.moto
                        ? kPrimaryColor
                        : kSecondaryColor,
                    shadows: autheticationBloc.state.tipoTransporte ==
                            TipoTransporte.moto
                        ? shadowKSN2
                        : null,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class TitleFiltro extends StatelessWidget {
  const TitleFiltro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      height: size.height * 0.05,
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Opciones de filtrado",
            style: estilosText!.tituloTipoMapa,
          ),
          IconButton(
              onPressed: () {
                context.pop();
              },
              icon: Icon(
                FontAwesomeIcons.xmark,
                color: kPrimaryColor,
                size: size.width * 0.08,
              ))
        ],
      ),
    );
  }
}

class ItemPuntoCorte extends StatelessWidget {
  const ItemPuntoCorte({
    super.key,
    required this.puntoCorte,
    required this.index,
  });

  final DataCorte puntoCorte;
  final int index;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AutheticationBloc>(context, listen: false);
    return GestureDetector(
        onTap: () {
          authBloc.add(OnChangedDataCorte(index));
          context.push("/informacionPC");
        },
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.01),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          height: size.height * 0.22,
          width: size.width,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width * 0.84,
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      puntoCorte.nombre,
                      textAlign: TextAlign.start,
                      style: estilosText!.tituloItemPC,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      puntoCorte.umz,
                      textAlign: TextAlign.start,
                      style: estilosText!.tituloItemPC,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      puntoCorte.data1,
                      textAlign: TextAlign.start,
                      style: estilosText!.subTituloItemPC,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      puntoCorte.data2,
                      textAlign: TextAlign.start,
                      style: estilosText!.subTituloItemPC,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      puntoCorte.data3,
                      textAlign: TextAlign.start,
                      style: estilosText!.subTituloItemPC,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      puntoCorte.data4,
                      textAlign: TextAlign.start,
                      style: estilosText!.subTituloItemPC,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
