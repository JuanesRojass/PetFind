import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas_bga/models/register/register_model_user.dart';


void main() {
  group('Registrar Cliente test', () {
    test('Verificar registro de usuario Cliente de manera exitosa', () async {
      
      //Datos definidos para hacer la prueba
      String username = "testuser";
      String email = "test@test.com";
      String password = "password123";
      String telefono = "1234567890";

      var registerModel = RegisterModel();

      var result = await registerModel.insertRecord(username, email, password, telefono);

      // Verificamos que el resultado sea el esperado, es decir 'Success'
      expect(result, contains('success'));
      expect(result['success'], 'true');
    });
  });
}