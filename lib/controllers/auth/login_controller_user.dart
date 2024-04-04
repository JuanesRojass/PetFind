import 'package:flutter/material.dart';
import 'package:mascotas_bga/models/auth/login_model_user.dart';
import 'package:go_router/go_router.dart';

class LoginController {
  final LoginModel _model = LoginModel();

  Future<void> login(
      BuildContext context, String email, String password) async {
    var dataUser = await _model.login(email, password);
    if (dataUser.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Correo o Contraseña incorrectas")));
    } else {
      if (dataUser[0]['rol'] == 'cliente') {
        // ignore: use_build_context_synchronously
        context.push('/pets');
      } else if (dataUser[0]['rol'] == 'administrador') {
        // ignore: use_build_context_synchronously
        context.push('/petsRefugio');
      }
    }
  }
}
