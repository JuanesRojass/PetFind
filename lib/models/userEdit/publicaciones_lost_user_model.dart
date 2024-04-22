import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class PublicacionesLostUserModel {
  Future<List<Map<String, dynamic>>> getPublicaciones(int idCliente) async {
    String uri =
        "http://$ipConnect/mascotas/view_publicacion_lost.php?idCliente=$idCliente";
    try {
      var response = await http.get(Uri.parse(uri));
      print("Response Resultado: ${response.body}");
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      print(e);
      return [];
    }
  }



  Future<bool> deletePublicacion(int idMascotaLost) async {
    final url = Uri.parse('http://$ipConnect/mascotas/delete_mascota_lost.php?idMascota=$idMascotaLost');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al borrar Mascota');
    }
  }
}