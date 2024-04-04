import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class LoginModel {
  Future<List<dynamic>> login(String email, String password) async {
    String uri = "http://$ipConnect/mascotas/login.php";
    var res = await http.post(Uri.parse(uri),
        body: {"email": email, "password": password});

    var datauser = jsonDecode(res.body);
    return datauser;
  }
}
