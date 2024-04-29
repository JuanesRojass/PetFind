import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/models/register/register_model_user.dart';

//Comrpuebo que los campos no estén vacios
class RegisterController {
  final RegisterModel _model = RegisterModel();

  Future<void> register(BuildContext context, String username, String email,
      String password, String telefono) async {
    if (username.isEmpty || password.isEmpty || email.isEmpty || telefono.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Campos Vacíos'),
            content: const Text(
              "Ha habido un error en el envío de datos en la solicitud, revisa si no te falta algún campo por llenar",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    var response = await _model.insertRecord(username, email, password, telefono);
    if (response.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Ha ocurrido un error al registrar la cuenta")),
      );
    } else {
      if (response["success"] == "true") {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Registro Exitoso'),
              content: const Text(
                  'Te has registrado de manera exitosa, ya puedes iniciar sesión, por favor usa nuestros servicios con responsabilidad.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.go('/login');
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print("Error: ${response['message']}");
      }
    }
  }
}
