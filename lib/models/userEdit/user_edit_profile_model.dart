import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class UserEditProfileModel {
  Future<bool> updateUser(String idCliente, String newUsername, String newTelefono) async {
    var url = Uri.parse('http://$ipConnect/mascotas/update_user.php?idCliente=$idCliente&username=$newUsername&telefono=$newTelefono');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al actualizar los datos: ${response.reasonPhrase}');
      return false;
    }
  }
}