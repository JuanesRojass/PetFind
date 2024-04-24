import 'package:mascotas_bga/models/delete/delete_street_pets_profile_model.dart';

final  DeleteStreetPetsProfileModel _model = DeleteStreetPetsProfileModel();

class DeleteStreetPetsProfileController {
  Future<bool> deletePublicacion(int idMascotaStreet) async {
    return await _model.deletePublicacion(idMascotaStreet);
  }
}