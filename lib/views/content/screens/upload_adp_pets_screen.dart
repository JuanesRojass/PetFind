import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/controllers/post/post_adp_pets_controller.dart';
import 'dart:io';
import 'package:mascotas_bga/controllers/providers/general/id_refugio_provider.dart';
import 'package:mascotas_bga/controllers/providers/general/id_tipo_mascota_provider.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import '../../../controllers/infrastructure/inputs/inputs.dart';

class UploadAdpPets extends ConsumerStatefulWidget {
  const UploadAdpPets({super.key});

  @override
  UploadAdpPetsState createState() => UploadAdpPetsState();
}

class UploadAdpPetsState extends ConsumerState<UploadAdpPets> {
  final PostAdpPetsController _controller = PostAdpPetsController();
  TextEditingController nombreMascota = TextEditingController();
  TextEditingController razaMascota = TextEditingController();
  TextEditingController tamanoMascota = TextEditingController();
  TextEditingController edadMascota = TextEditingController();
  TextEditingController colorMascota = TextEditingController();
  TextEditingController descMascota = TextEditingController();
  TextEditingController saludMascota = TextEditingController();
  TextEditingController sexoMascota = TextEditingController();
  TextEditingController tipoMascota = TextEditingController();

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
    await _controller.getImage(imagePicker,
        (File? file, String? name, String? data) {
      setState(() {
        imagepath = file;
        imagename = name;
        imagedata = data;
      });
    });
  }

  Future<void> getImage2() async {
    await _controller.getImage2(imagePicker,
        (File? file, String? name, String? data) {
      setState(() {
        imagepath2 = file;
        imagename2 = name;
        imagedata2 = data;
      });
    });
  }

  Future<void> getImage3() async {
    await _controller.getImage3(imagePicker,
        (File? file, String? name, String? data) {
      setState(() {
        imagepath3 = file;
        imagename3 = name;
        imagedata3 = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final idCliente = ref.watch(idRefugioProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Registrar Mascota en Adopción")),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(children: [
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
              DropDownMenuSexo(controller: sexoMascota),
              const SizedBox(height: 30),
              DropDownMenuTamano(
                controller: tamanoMascota,
              ),
              const SizedBox(height: 30),
              DropDownMenuEdad(controller: edadMascota),
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
              CustomTextFormField(
                label: 'Estado de Salud',
                keyboardType: TextInputType.text,
                controller: saludMascota,
                // onChanged: loginCubit.misionChanged,
                // errorMessage: misionCubit.errorMessage,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Registrar Mascota',
                  buttonColor: Colors.purple,
                  onPressed: () {
                    _controller.registrarMascotaAdopcion(
                        nombreMascota: nombreMascota.text,
                        tipoMascota: ref.watch(idTipoMascotaProvider),
                        razaMascota: ref.watch(idRazaProvider),
                        tamanoMascota: tamanoMascota.text,
                        colorMascota: colorMascota.text,
                        sexoMascota: sexoMascota.text,
                        edadMascota: edadMascota.text,
                        descMascota: descMascota.text,
                        saludMascota: saludMascota.text,
                        idRefugio: idCliente,
                        imagedata: imagedata,
                        imagename: imagename,
                        imagedata2: imagedata2,
                        imagename2: imagename2,
                        imagedata3: imagedata3,
                        imagename3: imagename3,
                        context: context);
                    // loginCubit.onSubmit();
                        ref.read(idTipoMascotaProvider.notifier).setId("");
                  },
                ),
              ),
              const SizedBox(height: 30),
            ])));
  }
}
