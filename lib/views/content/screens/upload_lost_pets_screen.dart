import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:mascotas_bga/controllers/providers/general/id_cliente_provider.dart';

import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/general/id_ciudad_provider.dart';
import 'package:mascotas_bga/controllers/providers/general/id_tipo_mascota_provider.dart';
import 'package:mascotas_bga/helpers/shared.dart';

import '../../../controllers/infrastructure/inputs/inputs.dart';

class UploadLostPets extends ConsumerStatefulWidget {
  const UploadLostPets({super.key});

  @override
  UploadLostPetsState createState() => UploadLostPetsState();
}

class UploadLostPetsState extends ConsumerState<UploadLostPets> {
  TextEditingController nombreMascota = TextEditingController();
  TextEditingController tipoMascota = TextEditingController();
  TextEditingController razaMascota = TextEditingController();
  TextEditingController tamanoMascota = TextEditingController();
  TextEditingController colorMascota = TextEditingController();
  TextEditingController sexoMascota = TextEditingController();
  TextEditingController descMascota = TextEditingController();
  TextEditingController recomMascota = TextEditingController();
  TextEditingController ciudadMascota = TextEditingController();
  TextEditingController barrioMascota = TextEditingController();
  TextEditingController direccionMascota = TextEditingController();

  File? imagepath;
  String? imagename;
  String? imagedata;
  File? imagepath2;
  String? imagename2;
  String? imagedata2;
  File? imagepath3;
  String? imagename3;
  String? imagedata3;

  ImagePicker imagePicker = ImagePicker();

  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imagepath = File(getimage!.path);
      imagename = getimage.path.split('/').last;
      imagedata = base64Encode(imagepath!.readAsBytesSync());
    });
  }

  Future<void> getImage2() async {
    var getimage2 = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (getimage2 != null) {
        imagepath2 = File(getimage2.path);
        imagename2 = getimage2.path.split('/').last;
        imagedata2 = base64Encode(imagepath2!.readAsBytesSync());
      } else {
        imagepath2 = null;
        imagename2 = null;
        imagedata2 = null;
      }
    });
  }

  Future<void> getImage3() async {
    var getimage3 = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (getimage3 != null) {
        imagepath3 = File(getimage3.path);
        imagename3 = getimage3.path.split('/').last;
        imagedata3 = base64Encode(imagepath3!.readAsBytesSync());
      } else {
        imagepath3 = null;
        imagename3 = null;
        imagedata3 = null;
      }
    });
  }

  Future<void> registrarMascotaPerdida(String idCliente) async {
    if (nombreMascota.text != "") {
      try {
        String uri = "http://$ipConnect/mascotas/insert_pet_lost.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nombre_mascota_lost": nombreMascota.text,
          "tipo_mascota_lost": ref.watch(idTipoMascotaProvider),
          "raza_mascota_lost": ref.watch(idRazaProvider),
          "tamano_mascota_lost": tamanoMascota.text,
          "color_mascota_lost": colorMascota.text,
          "sexo_mascota_lost": sexoMascota.text,
          "desc_mascota_lost": descMascota.text,
          "recom_mascota_lost": recomMascota.text,
          "ciudad_mascota_lost": ref.watch(idCiudadProvider),
          "barrio_mascota_lost": ref.watch(idBarrioProvider),
          "direccion_mascota_lost": direccionMascota.text,
          "idCliente": idCliente,
          "data": imagedata,
          "name": imagename,
          "data2": imagedata2 ?? "",
          "name2": imagename2 ?? "",
          "data3": imagedata3 ?? "",
          "name3": imagename3 ?? "",
        });
        print('Response body: ${res.body}');

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("uploaded");
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final idCliente = ref.watch(idClienteProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Mascota Perdida")),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
                child: Column(children: [
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: Column(
                    children: [
                      imagepath != null
                          ? Image.file(
                              imagepath!,
                              width: 100,
                              height: 100,
                            )
                          : const Icon(
                              Icons.image_search_rounded,
                              size: 50,
                            ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          getImage();
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(const Size(120,
                              50)), // Ajusta el ancho según tus necesidades
                        ),
                        child: const Text(
                          "Agregar imagen 1",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    children: [
                      imagepath2 != null
                          ? Image.file(
                              imagepath2!,
                              width: 100,
                              height: 100,
                            )
                          : const Icon(
                              Icons.image_search_rounded,
                              size: 50,
                            ),
                      const SizedBox(height: 30),
                      imagepath != null
                          ? ElevatedButton(
                              onPressed: () {
                                getImage2();
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(
                                    120,
                                    50)), // Ajusta el ancho según tus necesidades
                              ),
                              child: const Text(
                                "Agregar imagen 2",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Selecciona Imagen 1 para agregar mas'),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(
                                    120,
                                    50)), // Ajusta el ancho según tus necesidades
                              ),
                              child: const Text(
                                "Agregar imagen 2",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(children: [
                    imagepath3 != null
                        ? Image.file(
                            imagepath3!,
                            width: 100,
                            height: 100,
                          )
                        : const Icon(
                            Icons.image_search_rounded,
                            size: 50,
                          ),
                    const SizedBox(height: 30),
                    imagepath2 != null
                        ? ElevatedButton(
                            onPressed: () {
                              getImage3();
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(
                                  120,
                                  50)), // Ajusta el ancho según tus necesidades
                            ),
                            child: const Text(
                              "Agregar imagen 3",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Selecciona imagen 1 y 2 para agregar mas'),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(
                                  120,
                                  50)), // Ajusta el ancho según tus necesidades
                            ),
                            child: const Text(
                              "Agregar imagen 3",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                  ]),
                ),
              ]),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: 'Nombre Mascota',
                keyboardType: TextInputType.text,
                controller: nombreMascota,
                // onChanged: loginCubit.usernameChanged,
                // errorMessage: usernameCubit.errorMessage,
              ),
              const SizedBox(height: 30),
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
              DropDownMenuTamano(
                controller: tamanoMascota,
              ),
              const SizedBox(height: 30),
              DropDownMenuColor(
                controller: colorMascota
                ),
              const SizedBox(height: 30),
              DropDownMenuSexo(
                controller: sexoMascota
                ),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: 'Descripción Mascota',
                keyboardType: TextInputType.text,
                controller: descMascota,
                // onChanged: loginCubit.misionChanged,
                // errorMessage: misionCubit.errorMessage,
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                label: 'Recompensa Mascota',
                keyboardType: TextInputType.text,
                controller: recomMascota,
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
                label: 'Dirección Mascota',
                keyboardType: TextInputType.text,
                controller: direccionMascota,
                // onChanged: loginCubit.misionChanged,
                // errorMessage: misionCubit.errorMessage,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Registrar',
                  buttonColor: Colors.purple,
                  onPressed: () {
                    registrarMascotaPerdida(idCliente);
                    // loginCubit.onSubmit();
                  },
                ),
              ),
              const SizedBox(height: 30),
            ]))),
      ),
    );
  }
}
