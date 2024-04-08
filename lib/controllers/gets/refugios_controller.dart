
import 'package:mascotas_bga/models/gets/refugios_model.dart';

class RefugiosController {
  final RefugiosModel _model = RefugiosModel();

  Future<List> getRefugios() async {
    return await _model.getRefugios();
  }
}