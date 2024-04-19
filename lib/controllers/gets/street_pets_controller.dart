import 'dart:async';

import 'package:mascotas_bga/models/gets/street_pets_model.dart';



class StreetPetsController {
  final StreetPetsModel _model = StreetPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasStreet({
      String? tipo,
      String? raza,
      String? sexo,
      String? tamano,
      String? ciudad,
  }) async {
    return await _model.getMascotasStreet(
      tipo: tipo,
      raza: raza,
      sexo: sexo,
      tamano: tamano,
      ciudad: ciudad,
    );
  }
}
