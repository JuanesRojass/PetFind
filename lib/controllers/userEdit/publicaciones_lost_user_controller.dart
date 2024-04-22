import 'package:mascotas_bga/models/userEdit/publicaciones_lost_user_model.dart';

class PublicacionesLostUserController {
  final  PublicacionesLostUserModel _model = PublicacionesLostUserModel();

  Future<List<Map<String, dynamic>>> getUser(int idCliente) async {
    return await _model.getPublicaciones(idCliente);
  }

  Future<bool> deletePublicacion(int idMascotaLost) async {
    return await _model.deletePublicacion(idMascotaLost);
  }
}