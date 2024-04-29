import 'dart:async';
import 'package:mascotas_bga/models/getMascotas/adp_pets_model.dart';

class AdpPetsController {
  final AdpPetsModel _model = AdpPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasAdp({
      String? tipo,
      String? raza,
      String? sexo,
      String? tamano,
      String? edad,
      String? ciudad,
  }) async {
    return await _model.getMascotasAdp(
      tipo: tipo,
      raza: raza,
      sexo: sexo,
      tamano: tamano,
      edad: edad,
      ciudad: ciudad,
    );
  }
}
