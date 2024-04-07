import 'dart:async';
import 'package:mascotas_bga/models/gets/adp_pets_model.dart';

class PetsController {
  final PetsAdpModel _model = PetsAdpModel();

  Future<List> getMascotasAdp() async {
    return await _model.getMascotasAdp();
  }
}
