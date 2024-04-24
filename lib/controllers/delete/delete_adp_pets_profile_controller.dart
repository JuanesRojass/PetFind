import 'package:mascotas_bga/models/delete/delete_adp_pets_profile_model.dart';

final  DeleteAdpPetsProfileModel _model = DeleteAdpPetsProfileModel();

class DeleteAdpPetsProfileController {
  Future<bool> deletePublicacion(int idMascotaAdp) async {
    return await _model.deletePublicacion(idMascotaAdp);
  }
}
