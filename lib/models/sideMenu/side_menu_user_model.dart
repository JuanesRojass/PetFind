import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class SideMenuUserModel {
  Future<List<Map<String, dynamic>>> getUser(int idCliente) async {
    String uri =
        "http://$ipConnect/mascotas/view_cliente.php?id=$idCliente";
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