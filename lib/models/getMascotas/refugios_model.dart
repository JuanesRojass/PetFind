import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class RefugiosModel {
  Future<List<Map<String, dynamic>>> getRefugios({
    String? ciudad,
  }) async {
    String uri = "http://$ipConnect/mascotas/view_refugios_info.php";

    Uri uriWithParams = Uri.parse(uri).replace(
      queryParameters: {
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
