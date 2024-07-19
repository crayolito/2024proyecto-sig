import 'package:app_sig2024/blocs/auth/authetication_bloc.dart';
import 'package:app_sig2024/blocs/location/location_bloc.dart';
import 'package:app_sig2024/features/geolocalizacion/infrastructure/repositories/geo_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_map_event.dart';
part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  final AutheticationBloc authBloc;
  final LocationBloc locationBloc;
  final geoDatasourceImpl = GeolocalizacionRepositoryImpl();

  GoogleMapBloc({
    required this.authBloc,
    required this.locationBloc,
  }) : super(GoogleMapState()) {
    on<OnInitFigureMap>((event, emit) async {
      Map<String, Marker> markers = {};

      for (int i = 0; i < authBloc.state.coordPuntosCorte.length; i++) {
        var puntoCorte = authBloc.state.coordPuntosCorte[i];
        final marker = Marker(
          markerId: MarkerId(puntoCorte.toString()),
          position: puntoCorte,
          anchor: const Offset(0.5, 0.5),
          flat: true,
          onTap: () {
            int index = i;
            authBloc.add(OnChangedDataCorte(index));
            event.context.push("/informacionPC");
          },
        );
        markers[puntoCorte.toString()] = marker;
      }
      emit(state.copyWith(markers: markers));
    });

    on<OnCreateRouteTodoPuntos>((event, emit) async {
      Map<String, Polyline> polilineas = {};

      Position posicionUsuario = await locationBloc.getActualLocation();
      LatLng posicion =
          LatLng(posicionUsuario.latitude, posicionUsuario.longitude);

      // LatLng posicion = const LatLng(-16.36485088715999, -60.97646113472762);
      String codigoPuntos = await geoDatasourceImpl.getRoutePuntosCorte(
          posicion,
          authBloc.state.coordPuntosCorte,
          authBloc.state.tipoTransporte,
          authBloc.state.tipoTrafico,
          authBloc.state.showAlternativa);
      List<PointLatLng> decodificacionPuntos =
          PolylinePoints().decodePolyline(codigoPuntos);
      List<LatLng> puntos = decodificacionPuntos
          .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
          .toList();
      final polilineaRuta = Polyline(
        polylineId: const PolylineId("ruta"),
        color: Colors.blue,
        points: puntos,
        width: 5,
      );
      polilineas["ruta"] = polilineaRuta;
      emit(state.copyWith(polylines: polilineas));
    });

    on<OnMapInitialControllerMap>((event, emit) async {
      mapController = event.controller;
      emit(state.copyWith(status: GoogleMapStatus.construido));
      add(OnInitFigureMap(event.context));
    });

    on<OnMapInitialControllerCamera>((event, emit) async {
      cameraPosition = event.cameraPosition;
      emit(state.copyWith(status: GoogleMapStatus.construido));
    });

    on<OnChangeTypeMap>((event, emit) {
      emit(state.copyWith(mapType: event.mapType));
    });
  }

  void moveCameraMyLocation(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLngZoom(newLocation, 17.5);
    mapController?.animateCamera(cameraUpdate);
  }

  void reorientMap() {
    if (mapController != null && cameraPosition != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: cameraPosition!.target, zoom: cameraPosition!.zoom)));
    }
  }

  Future<void> reorientarCamaraALaUbicacionActual() async {
    final ubicacionActual = await locationBloc.getActualLocation();
    if (mapController != null) {
      final cameraPosition = CameraPosition(
        target: LatLng(ubicacionActual.latitude, ubicacionActual.longitude),
        zoom: 18,
      );
      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  Future<void> orientarCamaraALaPosicion() async {
    final posicion = await locationBloc.getActualLocation();

    if (mapController != null) {
      final cameraPosition = CameraPosition(
        target: LatLng(posicion.latitude, posicion.longitude),
        zoom: 18,
      );

      mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  @override
  Future<void> close() {
    mapController?.dispose();
    add(const OnResetState());
    return super.close();
  }
}
