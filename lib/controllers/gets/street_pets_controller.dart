import 'dart:async';

import 'package:mascotas_bga/models/gets/street_pets_model.dart';



class StreetPetsController {
  final StreetPetsModel _model = StreetPetsModel();

  Future<List<Map<String, dynamic>>> getMascotasStreet() async {
    return await _model.getMascotasStreet();
  }
}
