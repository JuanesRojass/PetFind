import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/models/auth/login_model_refugio.dart';
import 'package:go_router/go_router.dart';

class LoginControllerRefugio {
  final LoginModelRefugio _model = LoginModelRefugio();
  final TextEditingController emailRefugio;
  final TextEditingController passwordRefugio;

  LoginControllerRefugio(
      {required this.emailRefugio, required this.passwordRefugio});

  Future<List> login(BuildContext context, WidgetRef ref, String email,
      String password) async {
    var dataUser = await _model.login(email, password);
    if (dataUser.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Correo o Contraseña incorrectas")));
    } else {
      if (dataUser[0]['id_estado_refugio_fk'] == '1') {
        ref.read(rolProvider.notifier).state = "Refugio";
        ref.read(idRefugioProvider.notifier).state = dataUser[0]['id_refugio'];
        ref.read(idUsuarioProvider.notifier).state = dataUser[0]['id_refugio'];
        // ignore: use_build_context_synchronously
        context.go('/pets');
        emailRefugio.clear();
        passwordRefugio.clear();
      } else if (dataUser[0]['id_estado_refugio_fk'] == '2') {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Refugio En Revisión'),
              content: const Text(
                  'Lo sentimos, el refugio aún no ha sido aprobada para poder ingresar al sistema - Estado de cuenta "Pendiente".'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    emailRefugio.clear();
                    passwordRefugio.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (dataUser[0]['id_estado_refugio_fk'] == '3') {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Refugio Rechazado'),
              content: const Text(
                  'Lo sentimos, el refugio ha sido rechazado del sistema, - Estado de cuenta "Rechazada".'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    emailRefugio.clear();
                    passwordRefugio.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
    return dataUser;
  }
}
