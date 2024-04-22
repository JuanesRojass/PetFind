import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class MascotaLostEditModel {
  Future<bool> updateMascotaLost(String idMascota, String nombreMascota, String tipoMascota, String razaMascota,
    String sexoMascota, String tamanoMascota, String colorMascota, String recomMascota, String descMascota,
    String ciudadMascota, String barrioMascota, String dirMascota) async {
    var url = Uri.parse('http://$ipConnect/mascotas/update_mascota_lost.php?idMascota=$idMascota&nombreMascota=$nombreMascota&tipoMascota=$tipoMascota&razaMascota=$razaMascota&sexoMascota=$sexoMascota&tamanoMascota=$tamanoMascota&colorMascota=$colorMascota&recomMascota=$recomMascota&descMascota=$descMascota&ciudadMascota=$ciudadMascota&barrioMascota=$barrioMascota&dirMascota=$dirMascota');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al actualizar los datos: ${response.reasonPhrase}');
      return false;
    }
  }
}