import 'package:mascotas_bga/models/refugioEdit/refugio_edit_profile_model.dart';


class RefugioEditProfileController {
  RefugioEditProfileModel userModel;

  RefugioEditProfileController(this.userModel);

  Future<bool> updateRefugio(String idRefugio, String nombreRefugio, String telefonoRefugio,
  String telefonoRefugioDos, String telefonoRefugioTres, String desRefugio, String misionRefugio,
  String ciudadRefugio, String barrioRefugio, String dirRefugio) {
    return userModel.updateRefugio(idRefugio, nombreRefugio, telefonoRefugio, telefonoRefugioDos, telefonoRefugioTres, desRefugio, misionRefugio, ciudadRefugio, barrioRefugio, dirRefugio);
  }
}