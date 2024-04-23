import 'dart:convert';
import 'dart:io';

import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/models/post/post_adp_pets_model.dart';

class PostAdpPetsController {
  final PostAdpPetsModel _model = PostAdpPetsModel();

  Future<void> registrarMascotaAdopcion({
    required String nombreMascota,
    required String tipoMascota,
    required String razaMascota,
    required String tamanoMascota,
    required String colorMascota,
    required String sexoMascota,
    required String edadMascota,
    required String descMascota,
    required String saludMascota,
    required String idRefugio,
    required String? imagedata,
    required String? imagename,
    required String? imagedata2,
    required String? imagename2,
    required String? imagedata3,
    required String? imagename3,
    required BuildContext context,
  }) async {
    if (_camposCompletos(
        nombreMascota,
        tipoMascota,
        razaMascota,
        tamanoMascota,
        colorMascota,
        sexoMascota,
        descMascota,
        saludMascota,
        imagename ?? '')) {
      await _model.registrarMascotaAdopcion(
        nombreMascota: nombreMascota,
        tipoMascota: tipoMascota,
        razaMascota: razaMascota,
        tamanoMascota: tamanoMascota,
        colorMascota: colorMascota,
        sexoMascota: sexoMascota,
        edadMascota: edadMascota,
        descMascota: descMascota,
        saludMascota: saludMascota,
        idRefugio: idRefugio,
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
            content: const Text('Los datos se enviaron correctamente.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.go("/pets");
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
                  'Por favor completa todos los campos y recuerda que debes agregar al menos una imagen'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  bool _camposCompletos(
      String nombreMascota,
      String tipoMascota,
      String razaMascota,
      String tamanoMascota,
      String colorMascota,
      String sexoMascota,
      String descMascota,
      String saludMascota,
      String imagename) {
    return nombreMascota.isNotEmpty &&
        tipoMascota.isNotEmpty &&
        razaMascota.isNotEmpty &&
        tamanoMascota.isNotEmpty &&
        colorMascota.isNotEmpty &&
        sexoMascota.isNotEmpty &&
        descMascota.isNotEmpty &&
        saludMascota.isNotEmpty &&
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
