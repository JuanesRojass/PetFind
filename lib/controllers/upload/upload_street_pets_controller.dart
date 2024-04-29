import 'dart:convert';
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/models/upload/upload_street_pets_model.dart';

class PostStreetPetsController {
  final PostStreetsPetsModel _model = PostStreetsPetsModel();

  Future<void> registrarMascotaCalle({
    required String tipoMascota,
    required String razaMascota,
    required String tamanoMascota,
    required String colorMascota,
    required String sexoMascota,
    required String descMascota,
    required String ciudadMascota,
    required String barrioMascota,
    required String direccionMascota,
    required String ubicacionMascota,
    required String idUsuario,
    required String nombreRol,
    required String? imagedata,
    required String? imagename,
    required String? imagedata2,
    required String? imagename2,
    required String? imagedata3,
    required String? imagename3,
    required BuildContext context,
  }) async {
    if (_camposCompletos(
        tipoMascota,
        ciudadMascota,
        direccionMascota,
        descMascota,
        imagename ?? '')) {
      await _model.registrarMascotaCalle(
        tipoMascota: tipoMascota,
        razaMascota: razaMascota,
        tamanoMascota: tamanoMascota,
        colorMascota: colorMascota,
        sexoMascota: sexoMascota,
        descMascota: descMascota,
        ciudadMascota: ciudadMascota,
        barrioMascota: barrioMascota,
        direccionMascota: direccionMascota,
        ubicacionMascota: ubicacionMascota,
        idUsuario: idUsuario,
        nombreRol: nombreRol,
        imagedata: imagedata,
        imagename: imagename,
        imagedata2: imagedata2,
        imagename2: imagename2,
        imagedata3: imagedata3,
        imagename3: imagename3,
      );
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Datos enviados correctamente'),
            content: const Text('La mascota encontrada en calle que has registrado ha sido publicada'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go("/street");
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Campos incompletos'),
              content: const Text(
                  'Por favor completa los campos obligatorios y recuerda que debes agregar al menos una imagen'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          });
    }
  }

  bool _camposCompletos(
      String tipoMascota,
      String ciudadMascota,
      String direccionMascota,
      String descMascota,
      String imagename) {
    return 
        tipoMascota.isNotEmpty &&
        ciudadMascota.isNotEmpty &&
        direccionMascota.isNotEmpty &&
        descMascota.isNotEmpty &&
        imagename.isNotEmpty;
  }

  Future<void> getImage(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }

    Future<void> getImageCamera(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }

  Future<void> getImage2(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }

      Future<void> getImageCamera2(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }

  Future<void> getImage3(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }

      Future<void> getImageCamera3(ImagePicker imagePicker,
      Function(File?, String?, String?) setImage) async {
    var getimage = await imagePicker.pickImage(source: ImageSource.camera);
    if (getimage != null) {
      setImage(File(getimage.path), getimage.path.split('/').last,
          base64Encode(File(getimage.path).readAsBytesSync()));
    }
  }
}
