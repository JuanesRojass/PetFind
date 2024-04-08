import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class RefugiosModel {
  Future<List> getRefugios() async {
    String uri = "http://$ipConnect/mascotas/view_refugios.php";
    try {
      var response = await http.get(Uri.parse(uri));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
