import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class RegisterModel{
  Future<Map<String, dynamic>> insertRecord(String username, String email, String password) async {
    try{
      String uri = "http://$ipConnect/mascotas/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "username": username,
          "password": password,
          "rol": 'cliente',
          "email": email,
        });
        var response = jsonDecode(res.body);
        return response;
    } catch (e) {
      print(e);
      return {};
    }
  }
}