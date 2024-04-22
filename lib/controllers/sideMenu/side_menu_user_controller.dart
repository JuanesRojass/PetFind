
import 'package:mascotas_bga/models/sideMenu/side_menu_user_model.dart';

class SideMenuUserController {
  final  SideMenuUserModel _model = SideMenuUserModel();

  Future<List<Map<String, dynamic>>> getUser(int idRefugio) async {
    return await _model.getUser(idRefugio);
  }
}