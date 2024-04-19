import 'dart:async';

import 'package:mascotas_bga/models/gets/lost_pets_model.dart';


class LostPetsController {
  final LostPetsModel _model = LostPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasLost({
      String? tipo,
      String? raza,
      String? sexo,
      String? tamano,
      String? ciudad,
  }) async {
    return await _model.getMascotasLost(
      tipo: tipo,
      raza: raza,
      sexo: sexo,
      tamano: tamano,
      ciudad: ciudad,
    );
  }
}
