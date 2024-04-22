import 'package:mascotas_bga/models/sideMenu/side_menu_refugio_model.dart';


class SideMenuRefugioController {
  final  SideMenuRefugioModel _model = SideMenuRefugioModel();

  Future<List<Map<String, dynamic>>> getRefugio(int idRefugio) async {
    return await _model.getRefugio(idRefugio);
  }
}