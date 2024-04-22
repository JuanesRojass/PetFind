import 'package:mascotas_bga/models/userEdit/publicaciones_street_user_model.dart';

class PublicacionesStreetUserController {
  final  PublicacionesStreetUserModel _model = PublicacionesStreetUserModel();

  Future<List<Map<String, dynamic>>> getPublicaciones(int idCliente) async {
    return await _model.getPublicaciones(idCliente);
  }

  Future<bool> deletePublicacion(int idMascotaStreet) async {
    return await _model.deletePublicacion(idMascotaStreet);
  }
}