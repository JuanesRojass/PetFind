import 'package:mascotas_bga/models/refugioEdit/publicaciones_street_refugio_model.dart';


class PublicacionesStreetRefugioController {
  final  PublicacionesStreetRefugioModel _model = PublicacionesStreetRefugioModel();

  Future<List<Map<String, dynamic>>> getPublicaciones(int idRefugio) async {
    return await _model.getPublicaciones(idRefugio);
  }

  Future<bool> deletePublicacion(int idMascotaStreet) async {
    return await _model.deletePublicacion(idMascotaStreet);
  }
}