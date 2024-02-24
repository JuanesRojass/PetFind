import 'package:go_router/go_router.dart';
// import 'package:mascotas_bga/features/auth/screens/register_screen_test.dart';
import 'package:mascotas_bga/features/auth/screens/screens.dart';
import 'package:mascotas_bga/features/content/screens/screens.dart';



final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
  

  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
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
  

]);
