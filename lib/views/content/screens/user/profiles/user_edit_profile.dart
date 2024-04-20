import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:http/http.dart' as http;

class UserEditProfile extends ConsumerStatefulWidget {
  const UserEditProfile({super.key});

  @override
  UserEditProfileState createState() => UserEditProfileState();
}

class UserEditProfileState extends ConsumerState<UserEditProfile> {
  final TextEditingController nombreInput = TextEditingController();
  final TextEditingController telefonoInput = TextEditingController();

  Future<void> updateUser() async {
    String idCliente = '26';
    String username = nombreInput.text;
    String telefono = telefonoInput.text;

    var url = Uri.parse(
        'http://$ipConnect/mascotas/update_user.php?idCliente=$idCliente&username=$username&telefono=$telefono');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Cambios guardados'),
          content: const Text('Los cambios se guardaron de manera exitosa, Se recomienda Cerrar Sesión y volvir a iniciar para ver los cambios por completo.'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
                context.pop(); // Cerrar el AlertDialog // Cerrar la pantalla actual
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Hubo un error en la solicitud HTTP, muestra un mensaje de error
      print('Error al actualizar los datos: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataClienteJson = ref.watch(dataUserProvider);

    final dataCliente = jsonDecode(dataClienteJson);
    final username = dataCliente[0]["username"];

    final telefono = dataCliente[0]["telefono_usuario"];
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mis Datos"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(
                  Icons.person_2_rounded,
                  size: 100,
                  color: Colors.orange,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Ingresa los datos que quieres cambiar.",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(children: [
                  const Text("Nombre Actual: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$username",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Nombre",
                  controller: nombreInput,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Text("Numero de Teléfono: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$telefono",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Teléfono",
                  controller: telefonoInput,
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    updateUser();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Guardar Cambios",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
