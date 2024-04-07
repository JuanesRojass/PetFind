import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class LostPetsModel {
  Future<List> getMascotasLost() async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_lost.php";
    try {
      var response = await http.get(Uri.parse(uri));
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
