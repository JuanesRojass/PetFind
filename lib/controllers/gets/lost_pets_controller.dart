import 'dart:async';

import 'package:mascotas_bga/models/gets/lost_pets_model.dart';


class LostPetsController {
  final LostPetsModel _model = LostPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasLost() async {
    return await _model.getMascotasLost();
  }
}
