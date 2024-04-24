import 'package:mascotas_bga/models/delete/delete_lost_pets_profile_model.dart';

final  DeleteLostPetsProfileModel _model = DeleteLostPetsProfileModel();

class DeleteLostPetsProfileController {
  Future<bool> deletePublicacion(int idMascotaLost) async {
    return await _model.deletePublicacion(idMascotaLost);
  }
}