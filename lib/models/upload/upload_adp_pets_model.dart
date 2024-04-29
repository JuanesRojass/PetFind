import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';


class PostAdpPetsModel {
  Future<void> registrarMascotaAdopcion({
    required String nombreMascota,
    required String tipoMascota,
    required String razaMascota,
    required String tamanoMascota,
    required String colorMascota,
    required String sexoMascota,
    required String edadMascota,
    required String descMascota,
    required String saludMascota,
    required String idRefugio,
    required String? imagedata,
    required String? imagename,
    required String? imagedata2,
    required String? imagename2,
    required String? imagedata3,
    required String? imagename3,
  }) async {
    if (nombreMascota.isNotEmpty) {
      try {
        String uri = "http://$ipConnect/mascotas/insert_pet_adp.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nombre_mascota_adp": nombreMascota,
          "tipo_mascota_adp": tipoMascota,
          "raza_mascota_adp": razaMascota,
          "tamano_mascota_adp": tamanoMascota,
          "color_mascota_adp": colorMascota,
          "sexo_mascota_adp": sexoMascota,
          "edad_mascota_adp": edadMascota,
          "desc_mascota_adp": descMascota,
          "salud_mascota_adp": saludMascota,
          "idRefugio": idRefugio,
          "data": imagedata,
          "name": imagename,
          "data2": imagedata2 ?? "",
          "name2": imagename2 ?? "",
          "data3": imagedata3 ?? "",
          "name3": imagename3 ?? "",
        });
        print('Response body: ${res.body}');

        var response = jsonDecode(res.body);
        if (response["success"] == "true") {
          print("uploaded");
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
