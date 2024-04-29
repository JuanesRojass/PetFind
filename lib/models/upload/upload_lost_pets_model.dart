import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';


class PostLostPetsModel {
  Future<void> registrarMascotaPerdida({
    required String nombreMascota,
    required String tipoMascota,
    required String razaMascota,
    required String tamanoMascota,
    required String colorMascota,
    required String sexoMascota,
    required String descMascota,
    required String recomMascota,
    required String ciudadMascota,
    required String barrioMascota,
    required String direccionMascota,
    required String idCliente,
    required String? imagedata,
    required String? imagename,
    required String? imagedata2,
    required String? imagename2,
    required String? imagedata3,
    required String? imagename3,
  }) async {
    if (nombreMascota.isNotEmpty) {
      try {
        String uri = "http://$ipConnect/mascotas/insert_pet_lost.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nombre_mascota_lost": nombreMascota,
          "tipo_mascota_lost": tipoMascota,
          "raza_mascota_lost": razaMascota,
          "tamano_mascota_lost": tamanoMascota,
          "color_mascota_lost": colorMascota,
          "sexo_mascota_lost": sexoMascota,
          "desc_mascota_lost": descMascota,
          "recom_mascota_lost": recomMascota,
          "ciudad_mascota_lost": ciudadMascota,
          "barrio_mascota_lost": barrioMascota,
          "direccion_mascota_lost": direccionMascota,
          "idCliente": idCliente,
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
