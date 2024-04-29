import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs.dart';
import 'package:mascotas_bga/controllers/upload/upload_street_pets_controller.dart';
import 'dart:io';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/controllers/user/editarDatos/mascota_lost_edit_user_controller.dart';
import 'package:mascotas_bga/controllers/user/editarDatos/mascota_street_edit_user_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/models/user/editarDatos/mascota_lost_edit_model.dart';
import 'package:mascotas_bga/models/user/editarDatos/mascota_street_edit_model.dart';

class MascotaStreetEdit extends ConsumerStatefulWidget {
  const MascotaStreetEdit({super.key, required this.mascotaStreetEdit});

  @override
  MascotaStreetEditState createState() => MascotaStreetEditState();
  final Map<String, dynamic> mascotaStreetEdit;
}

class MascotaStreetEditState extends ConsumerState<MascotaStreetEdit> {
  final MascotaStreetEditController _controller =
      MascotaStreetEditController(MascotaStreetEditModel());
  TextEditingController razaMascota = TextEditingController();
  TextEditingController tamanoMascota = TextEditingController();
  TextEditingController colorMascota = TextEditingController();
  TextEditingController descMascota = TextEditingController();
  TextEditingController sexoMascota = TextEditingController();
  TextEditingController tipoMascota = TextEditingController();
  TextEditingController ciudadMascota = TextEditingController();
  TextEditingController barrioMascota = TextEditingController();
  TextEditingController dirMascota = TextEditingController();

  // File? imagepath;
  // String? imagename;
  // String? imagedata;
  // File? imagepath2;
  // String? imagename2;
  // String? imagedata2;
  // File? imagepath3;
  // String? imagename3;
  // String? imagedata3;

  ImagePicker imagePicker = ImagePicker();

  Future<void> updateMascotaStreet() async {
    String idMascota = widget.mascotaStreetEdit["id_mascota_calle"];
    String tipo = ref.watch(nombreTipoProvider);
    String raza = ref.watch(nombreRazaProvider);
    String sexo = sexoMascota.text;
    String tamano = tamanoMascota.text;
    String color = colorMascota.text;
    String desc = descMascota.text;
    String ciudad = ref.watch(nombreCiudadProvider);
    String barrio = ref.watch(nombreBarrioProvider);
    String dir = razaMascota.text;

    bool success = await _controller.updateMascotaStreet(idMascota, tipo,
        raza, sexo, tamano, color, desc, ciudad, barrio, dir);

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

    // Future<void> getImage() async {
    //   await _controller.getImage(imagePicker,
    //       (File? file, String? name, String? data) {
    //     setState(() {
    //       imagepath = file;
    //       imagename = name;
    //       imagedata = data;
    //     });
    //   });
    // }

    // Future<void> getImage2() async {
    //   await _controller.getImage2(imagePicker,
    //       (File? file, String? name, String? data) {
    //     setState(() {
    //       imagepath2 = file;
    //       imagename2 = name;
    //       imagedata2 = data;
    //     });
    //   });
    // }

    // Future<void> getImage3() async {
    //   await _controller.getImage3(imagePicker,
    //       (File? file, String? name, String? data) {
    //     setState(() {
    //       imagepath3 = file;
    //       imagename3 = name;
    //       imagedata3 = data;
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // final idUsuario = ref.watch(idUsuarioProvider);
    // final nombreRol = ref.watch(rolProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Modificar Datos")),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(children: [
              // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              //   Expanded(
              //       child: Column(children: [
              //     Wrap(alignment: WrapAlignment.spaceEvenly, children: [
              //       Image.network(
              //         // ignore: prefer_interpolation_to_compose_strings
              //         "http://$ipConnect/mascotas/" +
              //             widget.mascotaStreetEdit["imagen_mascota"],
              //         width: 100,
              //         height: 150,
              //         fit: BoxFit.cover,
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       if(widget.mascotaStreetEdit["imagen_mascota_dos"] != null)
              //       Image.network(
              //         // ignore: prefer_interpolation_to_compose_strings
              //         "http://$ipConnect/mascotas/" +
              //             widget.mascotaStreetEdit["imagen_mascota_dos"],
              //         width: 100,
              //         height: 150,
              //         fit: BoxFit.cover,
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       if(widget.mascotaStreetEdit["imagen_mascota_tres"] != null)
              //       Image.network(
              //         // ignore: prefer_interpolation_to_compose_strings
              //         "http://$ipConnect/mascotas/" +
              //             widget.mascotaStreetEdit["imagen_mascota_tres"],
              //         width: 100,
              //         height: 150,
              //         fit: BoxFit.cover,
              //       )
              //     ]),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: DropdownTipo(
                        controller: tipoMascota,
                      )),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: DropdownRazas(
                        controller: razaMascota,
                      )),
                  const SizedBox(height: 30),
                  DropDownMenuSexo(controller: sexoMascota),
                  const SizedBox(height: 30),
                  DropDownMenuTamano(
                    controller: tamanoMascota,
                  ),
                  const SizedBox(height: 30),
                  DropDownMenuColor(controller: colorMascota),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Descripción Mascota',
                    keyboardType: TextInputType.text,
                    controller: descMascota,
                    // onChanged: loginCubit.misionChanged,
                    // errorMessage: misionCubit.errorMessage,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: DropdownCiudades(
                        controller: ciudadMascota,
                      )),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: DropdownBarrios(
                        controller: barrioMascota,
                      )),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    label: 'Dirección Donde se Perdio',
                    keyboardType: TextInputType.text,
                    controller: dirMascota,
                    // onChanged: loginCubit.misionChanged,
                    // errorMessage: misionCubit.errorMessage,
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      updateMascotaStreet();
                      ref.read(idTipoMascotaProvider.notifier).setId("");
                      ref.read(idCiudadProvider.notifier).setId("");
                      ref.read(nombreCiudadProvider.notifier).setName("");
                      ref.read(nombreBarrioProvider.notifier).setName("");
                      ref.read(nombreTipoProvider.notifier).setName("");
                      ref.read(nombreRazaProvider.notifier).setName("");
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
                  ),
                  const SizedBox(height: 30),
                ]))
            );
  }
}
