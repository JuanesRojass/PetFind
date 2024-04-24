import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class DeleteLostPetsProfileModel {
  Future<bool> deletePublicacion(int idMascotaLost) async {
    final url = Uri.parse(
        'http://$ipConnect/mascotas/delete_mascota_lost.php?idMascota=$idMascotaLost');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al borrar Mascota');
    }
  }
}