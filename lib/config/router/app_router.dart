import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/views/auth/screens/login_refugio_screen.dart';
import 'package:mascotas_bga/views/auth/screens/screens.dart';
import 'package:mascotas_bga/views/content/screens/screens.dart';

final GoRouter router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/loginRefugio',
    builder: (context, state) => const LoginRefugioScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/pets',
    builder: (context, state) => const PetsScreen(),
  ),
  GoRoute(
    path: '/petsRefugio',
    builder: (context, state) => const PetsRefugioScreen(),
  ),
  GoRoute(
    path: '/lost',
    builder: (context, state) => const LostPetsScreen(),
  ),
  GoRoute(
    path: '/user',
    builder: (context, state) => const UserProfileScreen(),
  ),
  GoRoute(
    path: '/street',
    builder: (context, state) => const StreetPetsScreen(),
  ),
  GoRoute(
    path: '/refugios',
    builder: (context, state) => const RefugiosScreen(),
  ),
  GoRoute(
    path: '/refugiosPerfil',
    builder: (context, state) {
      final refugio = state.extra as Map<dynamic, dynamic>? ?? {};
      return RefugioPerfil(refugio: refugio);
    },
  ),
]);
