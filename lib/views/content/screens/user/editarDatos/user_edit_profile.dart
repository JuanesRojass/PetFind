import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/user/editarDatos/user_edit_profile_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/models/user/editarDatos/user_edit_profile_model.dart';

class UserEditProfile extends ConsumerStatefulWidget {
  const UserEditProfile({super.key, required this.cliente});

  @override
  UserEditProfileState createState() => UserEditProfileState();
  final Map<String, dynamic> cliente;
}

class UserEditProfileState extends ConsumerState<UserEditProfile> {
  final TextEditingController nombreInput = TextEditingController();
  final TextEditingController telefonoInput = TextEditingController();

  final UserEditProfileController _controller =
      UserEditProfileController(UserEditProfileModel());

  Future<void> updateUser() async {
    String idCliente = ref.watch(idClienteProvider);
    String username = nombreInput.text;
    String telefono = telefonoInput.text;

    bool success = await _controller.updateUser(idCliente, username, telefono);

    if (success) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Cambios guardados'),
          content: const Text('Los cambios se guardaron de manera exitosa.'),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Error'),
          content: const Text('No se pudieron guardar los cambios.'),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = widget.cliente["username"];
    final telefono = widget.cliente["telefono_usuario"];

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
