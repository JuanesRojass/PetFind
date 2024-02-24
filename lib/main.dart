import 'package:flutter/material.dart';
import 'package:mascotas_bga/config/router/app_router.dart';
import 'package:mascotas_bga/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp())   
    );
    
}

// final String username;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
