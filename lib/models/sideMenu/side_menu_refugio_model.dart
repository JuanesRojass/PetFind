import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class SideMenuRefugioModel {
  Future<List<Map<String, dynamic>>> getRefugio(int idRefugio) async {
    String uri =
        "http://$ipConnect/mascotas/view_refugio.php?id=$idRefugio";
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