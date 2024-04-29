// import 'dart:convert';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
import 'package:mascotas_bga/models/refugio/editarDatos/mascota_adp_edit_model.dart';

class MascotaAdpEditController {
  MascotaAdpEditModel userModel;

  MascotaAdpEditController(this.userModel);

  Future<bool> updateMascotaAdp(String idMascota, String nombreMascota, String tipoMascota,
    String razaMascota, String sexoMascota, String tamanoMascota, String colorMascota, String edad, String descMascota,
    String ciudadMascota, String barrioMascota, String dirMascota) {
    return userModel.updateMascotaAdp(idMascota, nombreMascota, tipoMascota, razaMascota, sexoMascota,
      tamanoMascota, colorMascota, edad, descMascota, ciudadMascota, barrioMascota, dirMascota);
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
