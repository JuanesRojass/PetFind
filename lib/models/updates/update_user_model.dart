// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:mascotas_bga/config/connect/connect_server.dart';

// class UpdateUserModel {
//   Future<List<Map<String, dynamic>>> updateUser({
//     String? nombre,
//     String? correo,
//     String? contrasena,
//     String? telefono,
//   }) async {
//     try {
//       String uri = "http://$ipConnect/mascotas/update_user.php";
//       var res = await http.post(Uri.parse(uri), body: {
//         "nombre": nombre,
//         "correo": correo,
//         "contrasena": contrasena,
//         "telefono": telefono,
//       });
//       print('Response body: ${res.body}');

//       var response = jsonDecode(res.body);
//       if (response["success"] == "true") {
//         print("uploaded");
//       } else {
//         print("some issue");
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
