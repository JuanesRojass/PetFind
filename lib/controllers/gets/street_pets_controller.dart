import 'package:mascotas_bga/models/gets/street_pets_model.dart';

class PetsStreetController {
  final PetsStreetModel _model = PetsStreetModel();

  Future<List> getMascotasStreet() async {
    return await _model.getMascotasStreet();
  }
}