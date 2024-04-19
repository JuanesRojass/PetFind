import 'package:go_router/go_router.dart';
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
    path: '/registerRefugio',
    builder: (context, state) => const RegisterRefugioScreen(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: '/pets',
    builder: (context, state) => const AdpPetsScreen(),
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
    path: '/street',
    builder: (context, state) => const StreetPetsScreen(),
  ),
  GoRoute(
    path: '/refugios',
    builder: (context, state) => const RefugiosScreen(),
  ),
  GoRoute(
    path: '/uploadLostPets',
    builder: (context, state) => const UploadLostPets(),
  ),
  GoRoute(
    path: '/uploadAdpPets',
    builder: (context, state) => const UploadAdpPets(),
  ),
  GoRoute(
    path: '/uploadStreetPets',
    builder: (context, state) => const UploadStreetPets(),
  ),
  GoRoute(
    path: '/refugiosProfile',
    builder: (context, state) {
      final refugio = state.extra as Map<String, dynamic>? ?? {};
      return RefugioProfile(refugio: refugio);
    },
  ),
  GoRoute(
    path: '/petsAdpProfile',
    builder: (context, state) {
      final mascotaAdp = state.extra as Map<String, dynamic>? ?? {};
      return PetsAdoptProfile(petsAdp: mascotaAdp);
    },
  ),
  GoRoute(
    path: '/petsLostProfile',
    builder: (context, state) {
      final mascotaLost = state.extra as Map<String, dynamic>? ?? {};
      return PetsLostProfile(petsLost: mascotaLost);
    },
  ),
  GoRoute(
    path: '/petsStreetProfile',
    builder: (context, state) {
      final mascotaStreet = state.extra as Map<String, dynamic>? ?? {};
      return PetsStreetProfile(petsStreet: mascotaStreet);
    },
  ),
]);
