import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class LoginModelRefugio {
  Future<List<dynamic>> login(String email, String password) async {
    String uri = "http://$ipConnect/mascotas/login_refugios.php";
    var res = await http.post(Uri.parse(uri),
        body: {
          "email_refugio": email,
          "password_refugio": password,
        });

    var datauser = jsonDecode(res.body);
    return datauser;
  }
}
