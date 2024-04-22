import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/models/userEdit/mascota_lost_edit_model.dart';
import 'package:mascotas_bga/models/userEdit/mascota_street_edit_model.dart';

class MascotaStreetEditController {
  MascotaStreetEditModel userModel;

  MascotaStreetEditController(this.userModel);

  Future<bool> updateMascotaStreet(String idMascota, String tipoMascota,
    String razaMascota, String sexoMascota, String tamanoMascota, String colorMascota, String descMascota,
    String ciudadMascota, String barrioMascota, String dirMascota) {
    return userModel.updateMascotaStreet(idMascota, tipoMascota, razaMascota, sexoMascota,
      tamanoMascota, colorMascota, descMascota, ciudadMascota, barrioMascota, dirMascota);
  }

  // Future<void> getImage(ImagePicker imagePicker,
  //     Function(File?, String?, String?) setImage) async {
  //   var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (getimage != null) {
  //     setImage(File(getimage.path), getimage.path.split('/').last,
  //         base64Encode(File(getimage.path).readAsBytesSync()));
  //   }
  // }

  // Future<void> getImage2(ImagePicker imagePicker,
  //     Function(File?, String?, String?) setImage) async {
  //   var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (getimage != null) {
  //     setImage(File(getimage.path), getimage.path.split('/').last,
  //         base64Encode(File(getimage.path).readAsBytesSync()));
  //   }
  // }

  // Future<void> getImage3(ImagePicker imagePicker,
  //     Function(File?, String?, String?) setImage) async {
  //   var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
  //   if (getimage != null) {
  //     setImage(File(getimage.path), getimage.path.split('/').last,
  //         base64Encode(File(getimage.path).readAsBytesSync()));
  //   }
  // }
}