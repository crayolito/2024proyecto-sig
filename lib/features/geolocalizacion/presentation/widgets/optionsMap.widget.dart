import 'package:animate_do/animate_do.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/config/constant/paletaColores.constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsMap extends StatelessWidget {
  const OptionsMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final googleMapBloc = BlocProvider.of<GoogleMapBloc>(context, listen: true);

    return FadeInRight(
        child: Padding(
      padding:
          EdgeInsets.only(right: size.width * 0.01, bottom: size.height * 0.01),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: "1",
              mini: true,
              onPressed: () {
                googleMapBloc.add(const OnCreateRouteTodoPuntos());
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                FontAwesomeIcons.road,
                size: size.width * 0.055,
                color: kSecondaryColor,
              ),
            ),
            FloatingActionButton(
              heroTag: "2",
              mini: true,
              onPressed: () async {
                await googleMapBloc.orientarCamaraALaPosicion();
              },
              backgroundColor: Colors.white.withOpacity(0.85),
              child: Icon(
                Icons.location_on,
                size: size.width * 0.07,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
