import 'package:app_sig2024/features/geolocalizacion/presentation/screens/informacionPC.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/screens/map-loading.sreen.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/screens/map.screen.dart';
import 'package:app_sig2024/features/geolocalizacion/presentation/screens/search.screen.dart';
import 'package:app_sig2024/features/home/presentation/screens/home.screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
  GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
  GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
  GoRoute(path: '/mapLoading', builder: (context, state) => const MapLoading()),
  GoRoute(
      path: '/informacionPC',
      builder: (context, state) => const InfoPuntoCorte()),
]);
