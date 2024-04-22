import 'package:mascotas_bga/models/refugioEdit/publicaciones_adp_refugio_model.dart';

class PublicacionesAdpRefugioController {
  final  PublicacionesAdpRefugioModel _model = PublicacionesAdpRefugioModel();

  Future<List<Map<String, dynamic>>> getPublicaciones(int idRefugio) async {
    return await _model.getPublicaciones(idRefugio);
  }


  Future<bool> deletePublicacion(int idMascotaAdp) async {
    return await _model.deletePublicacion(idMascotaAdp);
  }
}