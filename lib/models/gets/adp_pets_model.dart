import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class AdpPetsModel {
  Future<List<Map<String, dynamic>>> getMascotasAdp(
    {
      String? tipo,
      String? raza,
      String? sexo,
      String? tamano,
      String? edad,
    }
  ) async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_adp.php";

    Uri uriWithParams = Uri.parse(uri).replace(
      queryParameters: {
        'tipo': tipo,
        'raza': raza,
        'sexo': sexo,
        'tamano': tamano,
        'edad': edad,
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