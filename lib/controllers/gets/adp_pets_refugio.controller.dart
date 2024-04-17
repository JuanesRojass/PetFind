import 'dart:async';

import 'package:mascotas_bga/models/gets/adp_pets_refugio_model.dart';


class AdpPetsRefugioController {
  final AdpPetsRefugioModel _model = AdpPetsRefugioModel();

  Future<List<Map<String, dynamic>>> getMascotasAdpRefugio(int idRefugio) async {
    return await _model.getMascotasAdpRefugio(idRefugio);
  }
}