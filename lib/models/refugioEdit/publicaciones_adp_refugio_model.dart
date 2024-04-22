import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class PublicacionesAdpRefugioModel {
  Future<List<Map<String, dynamic>>> getPublicaciones(int idRefugio) async {
    String uri =
        "http://$ipConnect/mascotas/view_publicacion_adp.php?idRefugio=$idRefugio";
    try {
      var response = await http.get(Uri.parse(uri));
      print("Response Resultado: ${response.body}");
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      print(e);
      return [];
    }
  }
}