
import 'package:mascotas_bga/models/userEdit/user_edit_profile_model.dart';

class UserEditProfileController {
  UserEditProfileModel userModel;

  UserEditProfileController(this.userModel);

  Future<bool> updateUser(String idCliente, String username, String telefono) {
    return userModel.updateUser(idCliente, username, telefono);
  }
}