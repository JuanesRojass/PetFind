import 'package:mascotas_bga/models/admin/solicitud_refugios_model.dart';


class SolicitudRefugiosController {
  final SolicitudRefugiosModel _model = SolicitudRefugiosModel();

  Future<List<Map<String, dynamic>>> getRefugios() async {
    return await _model.getRefugios();
  }

  Future<Map<String, dynamic>> updateEstado(String idRefugio, int idEstado) async {
    return await _model.updateEstado(idRefugio, idEstado);
  }
}
