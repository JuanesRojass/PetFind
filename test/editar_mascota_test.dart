import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas_bga/models/user/editarDatos/mascota_lost_edit_model.dart';

void main() {
  group('Actualizar Mascota Perdida Test', () {
    test(
        'Verificar actualización de datos de mascota perdida de manera exitosa',
        () async {
      // Datos de prueba
      String idMascota = "98";
      String nombreMascota = "Kyarita";
      String tipoMascota = "";
      String razaMascota = "";
      String sexoMascota = "";
      String tamanoMascota = "";
      String colorMascota = "";
      String recomMascota = "";
      String descMascota = "";
      String ciudadMascota = "";
      String barrioMascota = "";
      String dirMascota = "";

      var editModel = MascotaLostEditModel();

      var response = await editModel.updateMascotaLost(
          idMascota,
          nombreMascota,
          tipoMascota,
          razaMascota,
          sexoMascota,
          tamanoMascota,
          colorMascota,
          recomMascota,
          descMascota,
          ciudadMascota,
          barrioMascota,
          dirMascota);

      expect(response, true);
    });
  });
}
