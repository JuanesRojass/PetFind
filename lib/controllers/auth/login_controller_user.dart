import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mascotas_bga/models/auth/login_model_user.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:go_router/go_router.dart';

class LoginController {
  final LoginModel _model = LoginModel();

  Future<void> login(BuildContext context, WidgetRef ref, String email,
      String password) async {
    var dataUser = await _model.login(email, password);
    if (dataUser.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Correo o Contraseña incorrectas")));
    } else {
      if (dataUser[0]['rol'] == 'cliente') {
        ref.read(rolProvider.notifier).state = "Cliente";
        ref.read(idClienteProvider.notifier).state = dataUser[0]['id'];
        ref.read(idUsuarioProvider.notifier).state = dataUser[0]['id'];
        ref.read(dataUserProvider.notifier).state = jsonEncode(dataUser);
        // ignore: use_build_context_synchronously
        context.go('/pets');
      } else if (dataUser[0]['rol'] == 'administrador') {
        ref.read(rolProvider.notifier).state = "Administrador";
        ref.read(dataUserProvider.notifier).state = jsonEncode(dataUser);
        // ignore: use_build_context_synchronously
        context.go('/pets');
      }
    }
  }
}
