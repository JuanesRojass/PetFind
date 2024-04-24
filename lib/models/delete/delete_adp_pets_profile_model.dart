import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class DeleteAdpPetsProfileModel {
  Future<bool> deletePublicacion(int idMascotaAdp) async {
    final url = Uri.parse(
        'http://$ipConnect/mascotas/delete_mascota_adp.php?idMascota=$idMascotaAdp');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al borrar Mascota');
    }
  }
}
