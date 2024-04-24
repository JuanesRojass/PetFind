import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class DeleteStreetPetsProfileModel {
  Future<bool> deletePublicacion(int idMascotaStreet) async {
    final url = Uri.parse(
        'http://$ipConnect/mascotas/delete_mascota_street.php?idMascota=$idMascotaStreet');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al borrar Mascota');
    }
  }
}