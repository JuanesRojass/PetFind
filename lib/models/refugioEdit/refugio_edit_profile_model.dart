import 'package:http/http.dart' as http;
import 'package:mascotas_bga/config/connect/connect_server.dart';

class RefugioEditProfileModel {
  Future<bool> updateRefugio(
      String idRefugio,
      String nombreRefugio,
      String telefonoRefugio,
      String telefonoRefugioDos,
      String telefonoRefugioTres,
      String desRefugio,
      String misionRefugio,
      String ciudadRefugio,
      String barrioRefugio,
      String dirRefugio) async {
        var encodedDirRefugio = Uri.encodeComponent(dirRefugio);
    var url = Uri.parse(
        'http://$ipConnect/mascotas/update_refugio.php?idRefugio=$idRefugio&nombreRefugio=$nombreRefugio&telefonoRefugio=$telefonoRefugio&telefonoRefugioDos=$telefonoRefugioDos&telefonoRefugioTres=$telefonoRefugioTres&desRefugio=$desRefugio&misionRefugio=$misionRefugio&ciudadRefugio=$ciudadRefugio&barrioRefugio=$barrioRefugio&dirRefugio=$encodedDirRefugio');
    var response = await http.get(url);
    print("RESPUESTA: ${response.body}");
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error al actualizar los datos: ${response.reasonPhrase}');
      return false;
    }
  }
}
