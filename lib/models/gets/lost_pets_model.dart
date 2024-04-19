import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class LostPetsModel {
  Future<List<Map<String, dynamic>>> getMascotasLost({
      String? tipo,
      String? raza,
      String? sexo,
      String? tamano,
      String? ciudad,
  }) async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_lost.php";

     Uri uriWithParams = Uri.parse(uri).replace(
      queryParameters: {
        'tipo': tipo,
        'raza': raza,
        'sexo': sexo,
        'tamano': tamano,
        'ciudad': ciudad,
      }
    );
    try {
      var response = await http.get(uriWithParams);
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      print(e);
      return [];
    }
  }
}