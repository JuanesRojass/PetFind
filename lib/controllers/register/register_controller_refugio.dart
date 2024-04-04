import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/models/register/register_model_refugio.dart';

class RegisterRefugioController {
  final RegisterRefugioModel _model = RegisterRefugioModel();
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController telefonoController;
  final TextEditingController descripcionController;
  final TextEditingController misionController;
  final TextEditingController ciudadController;
  final TextEditingController barrioController;
  final TextEditingController direccionController;

  RegisterRefugioController({
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.telefonoController,
    required this.descripcionController,
    required this.misionController,
    required this.ciudadController,
    required this.barrioController,
    required this.direccionController
    });

  
  Future<void> registerRefugio(
      BuildContext context,
      WidgetRef ref,
      String username,
      String email,
      String password,
      String telefono,
      String descripcion,
      String mision,
      String ciudad,
      String barrio,
      String direccion) async {
    if (username.isEmpty ||
        password.isEmpty ||
        email.isEmpty ||
        telefono.isEmpty) {
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

    var response = await _model.registerRefugio(ref, username, email, password,
        telefono, descripcion, mision, ciudad, barrio, direccion);

    if (response['success']) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Solicitud Enviada'),
            content: const Text(
                'Tu Solicitud ha sido enviada, la revisión puede tardar un tiempo, en el correo registrado llegará el aviso de el estado de tu cuenta al ser revisada por Nosotros, Gracias.".'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  usernameController.clear();
                  emailController.clear();
                  passwordController.clear();
                  telefonoController.clear();
                  descripcionController.clear();
                  misionController.clear();
                  ciudadController.clear();
                  barrioController.clear();
                  direccionController.clear();
                  Navigator.of(context).pop();
                  context.push('/loginRefugio');
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
