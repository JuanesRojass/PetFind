import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';

class RegisterRefugioModel {
  Future<Map<String, dynamic>> registerRefugio(
      WidgetRef ref,
      String username,
      String email,
      String password,
      String telefono,
      String descripcion,
      String mision,
      String ciudad,
      String barrio,
      String direccion) async {
    String uri = "http://$ipConnect/mascotas/insert_refugio.php";
    var res = await http.post(Uri.parse(uri), body: {
      "nombre_refugio": username,
      "email_refugio": email,
      "password_refugio": password,
      "telefono_refugio": telefono,
      "desc_refugio": descripcion,
      "mision_refugio": mision,
      "ciudad_refugio": ref.watch(idCiudadProvider),
      "barrio_refugio": ref.watch(idBarrioProvider),
      "direccion_refugioo": direccion,
      "estado_refugio": '2',
    });
    print(jsonDecode(res.body));
    return jsonDecode(res.body);
  }
}
