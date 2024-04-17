import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class StreetPetsModel {
  Future<List<Map<String, dynamic>>> getMascotasStreet() async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_street.php";
    try {
      var response = await http.get(Uri.parse(uri));
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      print(e);
      return [];
    }
  }
}
