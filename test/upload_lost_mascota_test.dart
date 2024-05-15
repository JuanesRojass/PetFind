import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas_bga/models/upload/upload_lost_pets_model.dart';

void main() {
  group('Registrar Mascota Perdida Test', () {
    test('Verificar registro de mascota perdida exitoso', () async {
      var postLostPetsModel = PostLostPetsModel();


      // Datos de prueba
      String nombreMascota = "Lucky";
      String tipoMascota = "1";
      String razaMascota = "54";
      String tamanoMascota = "Grande";
      String colorMascota = "Blanco";
      String sexoMascota = "Masculino";
      String descMascota = "Muy amigable";
      String recomMascota = "20.000";
      String ciudadMascota = "1";
      String barrioMascota = "23";
      String direccionMascota = "Calle 123 #45-67";
      String idCliente = "26";
      String? imagedata = "dataImagen";
      String? imagename = "image332343221.jpg";
      String? imagedata2 = "";
      String? imagename2 = "";
      String? imagedata3 = "";
      String? imagename3 = "";

      
      var response = await postLostPetsModel.registrarMascotaPerdida(
        nombreMascota: nombreMascota,
        tipoMascota: tipoMascota,
        razaMascota: razaMascota,
        tamanoMascota: tamanoMascota,
        colorMascota: colorMascota,
        sexoMascota: sexoMascota,
        descMascota: descMascota,
        recomMascota: recomMascota,
        ciudadMascota: ciudadMascota,
        barrioMascota: barrioMascota,
        direccionMascota: direccionMascota,
        idCliente: idCliente,
        imagedata: imagedata,
        imagename: imagename,
        imagedata2: imagedata2,
        imagename2: imagename2,
        imagedata3: imagedata3,
        imagename3: imagename3,
      );
      
      // expect(response, contains('success'));
      // expect(response ['success'], true);

    });
  });
}