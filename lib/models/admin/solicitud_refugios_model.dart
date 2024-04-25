import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class SolicitudRefugiosModel {
  Future<List<Map<String, dynamic>>> getRefugios() async {
    String uri =
        "http://$ipConnect/mascotas/view_solicitud_refugios.php";
    try {
      var response = await http.get(Uri.parse(uri));
      print("Response Resultado: ${response.body}");
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } catch (e) {
      print(e);
      return [];
    }
  }


    Future<Map<String, dynamic>> updateEstado(String idRefugio, int idEstado) async {
    String uri = "http://$ipConnect/mascotas/update_estado_refugio.php";
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: {
          'idRefugio': idRefugio.toString(),
          'idEstado': idEstado.toString(),
        }
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {'error': 'Failed to update status.'};
      }
    } catch (e) {
      print(e);
      return {'error': 'Failed to connect to the server.'};
    }
  }
}
