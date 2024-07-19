import 'package:animate_do/animate_do.dart';
import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/googleMap/google_map_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/screens/map-loading.sreen.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/views/google-map.view.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/optionsMap.widget.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/widgets/searchBarCustom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);
    return BlocBuilder<LocationBloc, LocationState>(
        builder: (context, locationState) {
      if (locationState.lastKnowLocationGM == null ||
          autheticationBloc.state.puntosCorte == null) {
        return const MapLoading();
      }

      return Material(
        child: Stack(
          children: [
            // MAPA GOOGLE
            const GoogleMapCustom(),
            // SEARCH BAR
            Positioned(
                top: size.height * 0.04,
                left: size.width * 0.01,
                child: const SearchBarCustom()),
            // OPTIONS MAP
            const OptionsMap(),
          ],
        ),
      );
    });
  }
}

class ScrollViewInfo extends StatelessWidget {
  const ScrollViewInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final autheticationBloc =
        BlocProvider.of<AutheticationBloc>(context, listen: true);
    return FadeInUp(
        child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.8,
            builder: (BuildContext context, ScrollController scrollController) {
              return Text(autheticationBloc.state.dataCorte!.nombre);
            }));
  }
}

class GoogleMapCustom extends StatelessWidget {
  const GoogleMapCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleMapBloc, GoogleMapState>(
        builder: (context, googleMapState) {
      return GoogleMapView(
        polygons: googleMapState.polygons.values.toSet(),
        markers: googleMapState.markers.values.toSet(),
        polylines: googleMapState.polylines.values.toSet(),
      );
    });
  }
}
