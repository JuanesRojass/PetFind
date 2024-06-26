import 'dart:async';

import 'package:mascotas_bga/models/getMascotas/refugios_model.dart';




class RefugiosController {
  final RefugiosModel _model = RefugiosModel();

  Future<List<Map<String, dynamic>>> getRefugios({
    String? ciudad,
  }) async {
    return await _model.getRefugios(
      ciudad: ciudad
    );
  }
}