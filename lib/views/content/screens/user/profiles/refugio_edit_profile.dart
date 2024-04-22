import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs/inputs.dart';
import 'package:mascotas_bga/controllers/providers/refugioEdit/refugio_edit_profile_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/models/refugioEdit/refugio_edit_profile_model.dart';

class RefugioEditProfile extends ConsumerStatefulWidget {
  const RefugioEditProfile({super.key, required this.refugio});

  @override
  RefugioEditProfileState createState() => RefugioEditProfileState();
  final Map<String, dynamic> refugio;
}

class RefugioEditProfileState extends ConsumerState<RefugioEditProfile> {
  final TextEditingController nombreInput = TextEditingController();
  final TextEditingController telefonoInput = TextEditingController();
  final TextEditingController telefonoDosInput = TextEditingController();
  final TextEditingController telefonoTresInput = TextEditingController();
  final TextEditingController desInput = TextEditingController();
  final TextEditingController misionInput = TextEditingController();
  final TextEditingController ciudadInput = TextEditingController();
  final TextEditingController barrioInput = TextEditingController();
  final TextEditingController dirInput = TextEditingController();

  final RefugioEditProfileController _controller =
      RefugioEditProfileController(RefugioEditProfileModel());

  Future<void> updateRefugio() async {
    String idRefugio = ref.watch(idRefugioProvider);
    String nombreRefugio = nombreInput.text;
    String telefonoRefugio = telefonoInput.text;
    String telefonoRefugioDos = telefonoDosInput.text;
    String telefonoRefugioTres = telefonoTresInput.text;
    String desRefugio = desInput.text;
    String misionRefugio = misionInput.text;
    String ciudadRefugio = ref.watch(nombreCiudadProvider);
    String barrioRefugio = ref.watch(nombreBarrioProvider);
    String dirRefugio = dirInput.text;

    bool success = await _controller.updateRefugio(
        idRefugio,
        nombreRefugio,
        telefonoRefugio,
        telefonoRefugioDos,
        telefonoRefugioTres,
        desRefugio,
        misionRefugio,
        ciudadRefugio,
        barrioRefugio,
        dirRefugio);

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
                context.pop();
                ref.read(idCiudadProvider.notifier).setId("");
                ref.read(idBarrioProvider.notifier).setId("");
                ref.read(nombreCiudadProvider.notifier).setName("");
                ref.read(nombreBarrioProvider.notifier).setName("");
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
    final nombreRefugio = widget.refugio["nombre_refugio"];
    final telefonoRefugio = widget.refugio["telefono_refugio"];
    final telefonoRefugioDos = widget.refugio["telefono_refugio_dos"];
    final telefonoRefugioTres = widget.refugio["telefono_refugio_tres"];
    final desRefugio = widget.refugio["desc_refugio"];
    final misionRefugio = widget.refugio["mision_refugio"];
    final ciudadRefugio = widget.refugio["ciudad_refugio"];
    final barrioRefugio = widget.refugio["barrio_refugio"];
    final dirRefugio = widget.refugio["direccion_refugio"];

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
                  Text("$nombreRefugio",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Nombre Refugio",
                  controller: nombreInput,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Text("Número de Teléfono: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$telefonoRefugio",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Teléfono",
                  controller: telefonoInput,
                ),
                Row(children: [
                  const Text("Número de Teléfono 2: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$telefonoRefugioDos",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Teléfono",
                  controller: telefonoDosInput,
                ),
                Row(children: [
                  const Text("Número de Teléfono 3: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$telefonoRefugioTres",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Teléfono",
                  controller: telefonoTresInput,
                ),
                Row(children: [
                  const Text("Descripción: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text("$desRefugio",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Descripción",
                  controller: desInput,
                ),
                Row(children: [
                  const Text("Misión: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Flexible(
                    child: Text("$misionRefugio",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey)),
                  )
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Misión",
                  controller: misionInput,
                ),
                Row(children: [
                  const Text("Ciudad: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$ciudadRefugio",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                DropdownCiudades(controller: ciudadInput),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Text("Barrio: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$barrioRefugio",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                DropdownBarrios(controller: barrioInput),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  const Text("Dirección: ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("$dirRefugio",
                      style: const TextStyle(fontSize: 16, color: Colors.grey))
                ]),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  label: "Cambiar Dirección",
                  controller: dirInput,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    updateRefugio();
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
