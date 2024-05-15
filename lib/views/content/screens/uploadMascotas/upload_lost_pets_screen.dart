import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/controllers/upload/upload_lost_pets_controller.dart';
import 'dart:io';
import 'package:mascotas_bga/helpers/shared.dart';
import '../../../../controllers/infrastructure/inputs.dart';

class UploadLostPets extends ConsumerStatefulWidget {
  const UploadLostPets({super.key});

  @override
  UploadLostPetsState createState() => UploadLostPetsState();
}

class UploadLostPetsState extends ConsumerState<UploadLostPets> {
  final PostLostPetsController _controller = PostLostPetsController();
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
    await _controller.getImage(imagePicker,
        (File? file, String? name, String? data) {
      setState(() {
        imagepath = file;
        imagename = name;
        imagedata = data;
      });
    });
  }

  Future<void> getImageCamera() async {
    await _controller.getImageCamera(imagePicker,
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

    Future<void> getImageCamera2() async {
    await _controller.getImageCamera(imagePicker,
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

    Future<void> getImageCamera3() async {
    await _controller.getImageCamera(imagePicker,
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
    final idCliente = ref.watch(idClienteProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Registrar Mascota Perdida", style: TextStyle(fontSize: 19))),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ListView(children: [
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: Column(
                    //Imagen 1 y Widgets
                    children: [
                      imagepath != null
                          ? Image.file(
                              imagepath!,
                              width: 100,
                              height: 120,
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
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40),),
                                 
                          ),
                          child: const Icon(Icons.photo_library),  
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getImageCamera();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40)),
                          ),
                          child: const Icon(Icons.camera_alt),  
                        ),
                    
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  //Imagen 2 y Widgets
                  child: Column(
                    children: [
                      imagepath2 != null
                          ? Image.file(
                              imagepath2!,
                              width: 100,
                              height: 120,
                            )
                          : const Icon(
                              Icons.image_search_rounded,
                              size: 50,
                            ),
                      const SizedBox(height: 30),
                      imagepath != null
                          ? Column(
                            children: [
                              ElevatedButton(
                          onPressed: () {
                            getImage2();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40),),
                                 
                          ),
                          child: const Icon(Icons.photo_library),  
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getImageCamera2();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40)),
                          ),
                          child: const Icon(Icons.camera_alt),  
                        ),
                    ])
                          : Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Selecciona Imagen 1 para agregar mas'),
                                    ),
                                  );
                                },
                              style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(60,
                                  40),),     
                              ),
                                child: const Icon(
                                  Icons.photo_library,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Selecciona Imagen 1 para agregar mas'),
                                    ),
                                  );
                                },
                              style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(60,
                                  40),),     
                              ),
                                child: const Icon(
                                  Icons.camera_alt,
                                ),
                              ),
                    ]),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Column(
                    //Imagen 3 y Widgets
                    children: [
                    imagepath3 != null
                        ? Image.file(
                            imagepath3!,
                            width: 100,
                            height: 120,
                          )
                        : const Icon(
                            Icons.image_search_rounded,
                            size: 50,
                          ),
                    const SizedBox(height: 30),
                    imagepath2 != null
                        ? Column(
                          children: [
                           ElevatedButton(
                          onPressed: () {
                            getImage3();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40),),      
                          ),
                          child: const Icon(Icons.photo_library),  
                        ),
                        ElevatedButton(
                          onPressed: () {
                            getImageCamera3();
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(60,
                                40)),
                          ),
                          child: const Icon(Icons.camera_alt),  
                        ),
                  ])
                        : Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Selecciona Imagen 1 y 2 para agregar mas'),
                                    ),
                                  );
                                },
                              style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(60,
                                  40),),     
                              ),
                                child: const Icon(
                                  Icons.photo_library,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Selecciona Imagen 1 y 2 para agregar mas'),
                                    ),
                                  );
                                },
                              style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(const Size(60,
                                  40),),     
                              ),
                                child: const Icon(
                                  Icons.camera_alt,
                                ),
                              ),
                    ]),
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
              DropDownMenuColor(controller: colorMascota),
              const SizedBox(height: 30),
              DropDownMenuSexo(controller: sexoMascota),
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
                label: 'Dirección ultima vez vista',
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
                  text: 'Registrar Mascota',
                  buttonColor: Colors.orange,
                  onPressed: () {
                    _controller.registrarMascotaPerdida(
                        nombreMascota: nombreMascota.text,
                        tipoMascota: ref.watch(idTipoMascotaProvider),
                        razaMascota: ref.watch(idRazaProvider),
                        tamanoMascota: tamanoMascota.text,
                        colorMascota: colorMascota.text,
                        sexoMascota: sexoMascota.text,
                        descMascota: descMascota.text,
                        recomMascota: recomMascota.text,
                        ciudadMascota: ref.watch(idCiudadProvider),
                        barrioMascota: ref.watch(idBarrioProvider),
                        direccionMascota: direccionMascota.text,
                        idCliente: idCliente,
                        imagedata: imagedata,
                        imagename: imagename,
                        imagedata2: imagedata2,
                        imagename2: imagename2,
                        imagedata3: imagedata3,
                        imagename3: imagename3,
                        context: context);
                    // loginCubit.onSubmit();

                    ref.read(idTipoMascotaProvider.notifier).setId("");
                    ref.read(idCiudadProvider.notifier).setId("");
                    ref.read(nombreTipoProvider.notifier).setName("");
                    ref.read(nombreRazaProvider.notifier).setName("");
          
                  },
                  
                ),
              ),
              const SizedBox(height: 30),
            ])));
  }
}
