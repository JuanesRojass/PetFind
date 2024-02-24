import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/features/providers/connect_provider.dart';

import '../../../shared/shared.dart';

class StreetPetsScreen extends StatefulWidget {
  const StreetPetsScreen({super.key});

  @override
  State<StreetPetsScreen> createState() => _StreetPetsScreenState();
}

class _StreetPetsScreenState extends State<StreetPetsScreen> {
  List mascotasCalle = [];

  Future<void> getMascotasAdp() async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_street.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        mascotasCalle = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getMascotasAdp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mascotas En Calle'),
        ),
        body: ListView.builder(
          itemCount: mascotasCalle.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(mascotasCalle[index]["direccion_mascota_calle"]),
                subtitle: Text(mascotasCalle[index]["imagen_mascota_calle"]),
              ),
            );
          },
        ),
        bottomNavigationBar: const BottomNavigationUser());
  }
}
