import 'package:flutter/material.dart';
import 'package:mascotas_bga/config/router/app_router.dart';
import 'package:mascotas_bga/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
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
