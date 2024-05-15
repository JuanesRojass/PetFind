import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas_bga/models/delete/delete_lost_pets_profile_model.dart';

void main() {
  group('Eliminar Publicación de Mascota Perdida Test', () {
    test('Verificar eliminación exitosa de una publicación de mascota perdida', () async {
      
      // Identificador de la mascota a borrar
      int idMascotaLost = 112;

      var deleteModel = DeleteLostPetsProfileModel();

      var response = await deleteModel.deletePublicacion(idMascotaLost);

      expect(response, true);
    });
  });
}