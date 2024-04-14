import 'dart:async';
import 'package:mascotas_bga/models/gets/adp_pets_model.dart';

class AdpPetsController {
  final AdpPetsModel _model = AdpPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasAdp() async {
    return await _model.getMascotasAdp();
  }
}
