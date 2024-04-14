import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';


class PostStreetsPetsModel {
  Future<void> registrarMascotaCalle({
    required String tipoMascota,
    required String razaMascota,
    required String tamanoMascota,
    required String colorMascota,
    required String sexoMascota,
    required String descMascota,
    required String ciudadMascota,
    required String barrioMascota,
    required String direccionMascota,
    required String idUsuario,
    required String nombreRol,
    required String? imagedata,
    required String? imagename,
    required String? imagedata2,
    required String? imagename2,
    required String? imagedata3,
    required String? imagename3,
  }) async {
    if (tipoMascota.isNotEmpty) {
      try {
        String uri = "http://$ipConnect/mascotas/insert_pet_street.php";
        var res = await http.post(Uri.parse(uri), body: {
          "tipo_mascota_street": tipoMascota,
          "raza_mascota_street": razaMascota,
          "tamano_mascota_street": tamanoMascota,
          "color_mascota_street": colorMascota,
          "sexo_mascota_street": sexoMascota,
          "desc_mascota_street": descMascota,
          "ciudad_mascota_street": ciudadMascota,
          "barrio_mascota_street": barrioMascota,
          "direccion_mascota_street": direccionMascota,
          "idUsuario": idUsuario,
          "nombreRol": nombreRol,
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