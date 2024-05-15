import 'package:flutter_test/flutter_test.dart';
import 'package:mascotas_bga/models/auth/login_model_user.dart';


void main() {
  group('Login Test', () {
    test('Verificar login exitoso', () async {

      // Datos de prueba
      String email = "juanes@gmail.com";
      String password = "123456";

      var loginModel = LoginModel();

      var result = await loginModel.login(email, password);

      expect(result.isNotEmpty, true);
    });
  });
}